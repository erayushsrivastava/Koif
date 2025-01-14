const express = require('express');
const router = express.Router();
const AWS = require('aws-sdk');

AWS.config.update({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const cognito = new AWS.CognitoIdentityServiceProvider();
const USER_POOL_ID = process.env.USERPOOL_ID;
const CLIENT_ID = process.env.CLIENT_ID;

const formatPhoneNumber = (phone) => {
  let cleaned = phone.replace(/[\s\-()]/g, '');
  if (!cleaned.startsWith('+')) {
    cleaned = '+' + cleaned;
  }
  return cleaned;
};

const validatePassword = (password) => {
  const errors = [];
  
  if (password.length < 8) {
    errors.push('Password must be at least 8 characters long');
  }
  if (!/[A-Z]/.test(password)) {
    errors.push('Password must contain at least one uppercase letter');
  }
  if (!/[a-z]/.test(password)) {
    errors.push('Password must contain at least one lowercase letter');
  }
  if (!/[0-9]/.test(password)) {
    errors.push('Password must contain at least one number');
  }
  if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
    errors.push('Password must contain at least one special character');
  }

  return {
    isValid: errors.length === 0,
    errors: errors
  };
};
// Signup endpoint with immediate password setup
router.post('/signup', async (req, res) => {
  try {
    const { userName, email, phoneNumber, address, password } = req.body;
    console.log('Starting signup process for:', phoneNumber);

    if (!userName || !email || !phoneNumber || !address || !password) {
      return res.status(400).json({
        error: 'Missing required fields',
        required: ['userName', 'email', 'phoneNumber', 'address', 'password']
      });
    }

    const passwordValidation = validatePassword(password);
    if (!passwordValidation.isValid) {
      return res.status(400).json({
        error: 'Password does not meet requirements',
        code: 'InvalidPasswordException',
        details: passwordValidation.errors
      });
    }
    const formattedPhone = formatPhoneNumber(phoneNumber);

    // Step 1: Create user in Cognito
    const createParams = {
      UserPoolId: USER_POOL_ID,
      Username: formattedPhone,
      TemporaryPassword: 'Temp123!@#',
      UserAttributes: [
        { Name: 'name', Value: userName },
        { Name: 'email', Value: email },
        { Name: 'phone_number', Value: formattedPhone },
        { Name: 'address', Value: address }
      ],
      MessageAction: 'SUPPRESS'
    };

    console.log('Creating user...');
    await cognito.adminCreateUser(createParams).promise();
    console.log('User created successfully');

    // Step 2: Set permanent password immediately
    console.log('Setting permanent password...');
    await cognito.adminSetUserPassword({
      UserPoolId: USER_POOL_ID,
      Username: formattedPhone,
      Password: password,
      Permanent: true
    }).promise();
    console.log('Password set permanently');

    // Step 3: Enable the user
    await cognito.adminUpdateUserAttributes({
      UserPoolId: USER_POOL_ID,
      Username: formattedPhone,
      UserAttributes: [
        {
          Name: 'email_verified',
          Value: 'true'
        },
        {
          Name: 'phone_number_verified',
          Value: 'true'
        }
      ]
    }).promise();
    console.log('User attributes updated');

    res.json({
      success: true,
      message: 'User registered successfully',
      username: formattedPhone
    });

  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({
      error: error.message,
      code: error.code || 'UnknownError'
    });
  }
});

// Signin endpoint using phone number directly
// Signin endpoint using phone number directly
router.post('/signin', async (req, res) => {
  try {
    const { phoneNumber, password } = req.body;
    console.log('Attempting signin for:', phoneNumber);

    if (!phoneNumber || !password) {
      return res.status(400).json({
        error: 'Phone number and password are required'
      });
    }

    const formattedPhone = formatPhoneNumber(phoneNumber);

    // Authenticate directly with phone number
    const authParams = {
      AuthFlow: 'USER_PASSWORD_AUTH',
      ClientId: CLIENT_ID,
      AuthParameters: {
        USERNAME: formattedPhone,
        PASSWORD: password
      }
    };

    console.log('Initiating authentication...');
    const signInResponse = await cognito.initiateAuth(authParams).promise();
    
    // Extract user information from the ID token
    const userId = signInResponse.AuthenticationResult.IdToken;
    const base64Url = userId.split('.')[1]; // Extract the payload part of the token
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join('')
    );
    
    USER_ID = JSON.parse(jsonPayload).sub;

    // Get the user's attributes from Cognito
    const userAttributesResponse = await cognito.adminGetUser({
      UserPoolId: USER_POOL_ID,  // replace with your user pool id
      Username: formattedPhone    // use the phone number as the username
    }).promise();

    // Map the attributes
    const attributes = userAttributesResponse.UserAttributes.reduce((acc, attr) => {
      acc[attr.Name] = attr.Value;
      return acc;
    }, {});

    // Return success response along with user attributes
    res.json({
      success: true,
      message: 'Successfully authenticated',
      tokens: {
        clientId: CLIENT_ID,
        userId: USER_ID,
        accessToken: signInResponse.AuthenticationResult.AccessToken,
        refreshToken: signInResponse.AuthenticationResult.RefreshToken,
        idToken: signInResponse.AuthenticationResult.IdToken,
        expiresIn: signInResponse.AuthenticationResult.ExpiresIn
      },
      user: {
        username: attributes['preferred_username'],  // You can use the attribute that stores the username
        email: attributes['email'],
        address: attributes['address'],  // Make sure the address is stored in the attributes
      }
    });

  } catch (error) {
    console.error('Signin error:', error);

    if (error.code === 'UserNotFoundException') {
      return res.status(401).json({
        error: 'User not found',
        code: 'UserNotFoundException'
      });
    }

    if (error.code === 'NotAuthorizedException') {
      return res.status(401).json({
        error: 'Incorrect phone number or password',
        code: 'NotAuthorizedException'
      });
    }

    res.status(500).json({
      error: error.message,
      code: error.code || 'UnknownError'
    });
  }
});


router.post('/update-profile', async (req, res) => {
  try {
    const { userName, email, phoneNumber, address } = req.body;
    console.log('Updating profile for:', phoneNumber);

    if (!phoneNumber) {
      return res.status(400).json({
        error: 'Phone number is required'
      });
    }

    const formattedPhone = formatPhoneNumber(phoneNumber);

    // Update user attributes
    const updateParams = {
      UserPoolId: USER_POOL_ID,
      Username: formattedPhone,
      UserAttributes: [
        { Name: 'name', Value: userName },
        { Name: 'email', Value: email },
        { Name: 'phone_number', Value: formattedPhone },
        { Name: 'address', Value: address }
      ]
    };

    console.log('Updating user attributes...');
    await cognito.adminUpdateUserAttributes(updateParams).promise();
    console.log('User attributes updated');

    res.json({
      success: true,
      message: 'Profile updated successfully'
    });

  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({
      error: error.message,
      code: error.code || 'UnknownError'
    });
  }
});

module.exports = router;