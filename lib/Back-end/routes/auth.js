// routes/auth.js

const express = require('express');
const { OAuth2Client } = require('google-auth-library');
const { generateOTP,
  storeOTP,
  verifyOTP,
  sendSMS} = require("../utils/otpService")
const router = express.Router();
// Google OAuth client ID (ensure this matches the one used in the OAuth Playground)
const CLIENT_ID = 'your_google_client_id.apps.googleusercontent.com';
const client = new OAuth2Client(CLIENT_ID);

// Google login route
router.post('/google-login', async (req, res) => {
  const { tokenId } = req.body;

  try {
    // Verify the ID token
    const ticket = await client.verifyIdToken({
      idToken: tokenId,
      audience: CLIENT_ID,
    });

    // Get user information from the payload
    const payload = ticket.getPayload();
    const { email, name, picture } = payload;

    // Handle your user login/registration logic here (e.g., find or create user in DB)
    res.status(200).json({ email, name, picture, message: 'Google login successful' });
  } catch (error) {
    res.status(401).json({ message: 'Invalid Google ID token' });
  }
});

router.post('/send-otp', async (req, res) => {
  try {
    const { phoneNumber } = req.body;
    const otp =await generateOTP()
    console.log(otp)
   await storeOTP(phoneNumber, otp);
    
   await sendSMS(
      phoneNumber,
      `Your verification code is: ${otp}. Valid for 5 minutes.`
    );

    res.json({ success: true, message: 'OTP sent successfully' });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

router.post('/verify-otp', (req, res) => {
  const { phoneNumber, otp } = req.body;
  const isValid = OTPService.verifyOTP(phoneNumber, otp);

  if (!isValid) {
    return res.status(400).json({
      success: false,
      message: 'Invalid or expired OTP'
    });
  }

  res.json({
    success: true,
    message: 'OTP verified successfully'
  });
});


module.exports = router;
