// routes/auth.js

const express = require('express');
const { OAuth2Client } = require('google-auth-library');
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

module.exports = router;
