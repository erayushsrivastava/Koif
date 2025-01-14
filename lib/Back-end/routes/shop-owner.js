const express = require('express');
const { v4: uuidv4 } = require('uuid');

const router = express.Router();
const AWS = require('aws-sdk');
aws = require('aws-sdk');
const docClient = new aws.DynamoDB.DocumentClient({
    region: process.env.AWS_REGION, // Replace with your AWS region
});

// Define Table Name
const dynamoDB = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = 'Services';
const cognito = new AWS.CognitoIdentityServiceProvider();
const USER_POOL_ID = process.env.SHOPOWNER_USER_POOL_ID;
const CLIENT_ID = process.env.SHOPOWNER_CLIENT_ID;

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
      const userId = signInResponse.AuthenticationResult.IdToken
      const base64Url = userId.split('.')[1]; // Extract the payload part of the token
      const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
      const jsonPayload = decodeURIComponent(
        atob(base64)
          .split('')
          .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
          .join('')
      );
      USER_ID = JSON.parse(jsonPayload).sub;
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

  
  
 
  router.post('/create-service', async (req, res) => {
    try {
        const {
            ownerId,
            serviceName,
            serviceType,
            price,
            rating,
            description,
            location,
            availability,
        } = req.body;

        // Log incoming request body for debugging
        console.log('Received request to create a service:', req.body);

        if (!ownerId || !serviceName || !serviceType || !price) {
            return res.status(400).json({ error: 'Missing required fields' });
        }

        // Generate a unique service ID
        const serviceId = uuidv4();
console.log('Generated service ID:', serviceId);
        // Define the DynamoDB params
        const params = {
            TableName: TABLE_NAME,
            Item: {
                ownerId,                // Partition Key
                serviceId,              // Sort Key
                serviceName,
                serviceType,
                price,
                rating: rating || null, // Optional field
                description: description || null,
                location: location || {}, // Optional Map
                availability: availability || [], // Optional List
                available: true,        // Default value
                createdAt: new Date().toISOString(), // Timestamp
            },
        };
        console.log('DynamoDB Params:', JSON.stringify(params, null, 2));

        // Insert item into DynamoDB
        await dynamoDB.put(params).promise();

        // Return success response
        res.status(201).json({
            message: 'Service created successfully',
            serviceId: serviceId,
            service: params.Item,
        });
    } catch (err) {
        console.error('Error creating service:', err);
        res.status(500).json({
            error: 'Error creating service',
            details: err.message,
        });
    }
});
    
router.post('/update-service', async (req, res) => {
    try {
        console.log('Received request to update a service:', req.body);
        const TABLE_NAME = 'Services';

        // Extract service details from the request body
        const {
            ownerId,
            serviceId,
            serviceName,
            serviceType,
            price,
            rating,
            description,
            location,
            availability,
        } = req.body;

        // Construct the DynamoDB item
        const params = {
            TableName: TABLE_NAME,
            Key: {
                ownerId, // Partition Key
                serviceId, // Sort Key
            },
            UpdateExpression:
                'SET serviceName = :serviceName, serviceType = :serviceType, price = :price, rating = :rating, description = :description, location = :location, availability = :availability',
            ExpressionAttributeValues: {
                ':serviceName': serviceName,
                ':serviceType': serviceType,
                ':price': price,
                ':rating': rating,
                ':description': description,
                ':location': location,
                ':availability': availability,
            },
        };

        console.log('Updating service in DynamoDB:', params);

        // Update item in DynamoDB
        await docClient.update(params).promise();

        console.log('Service updated successfully:', params);
        res.status(200).json({ message: 'Service updated successfully' });
    } catch (error) {
        console.error('Error updating service:', error);
        res.status(500).json({ error: error.message });
    }
});


module.exports = router;
