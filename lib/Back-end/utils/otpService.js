


const AWS = require('aws-sdk');
require('dotenv').config();

// Initialize AWS SNS
const sns = new AWS.SNS({
  region: process.env.AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

// In-memory OTP storage
const otpStorage = new Map();

class SNSOTPService {
  static generateOTP() {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  static async sendOTP(phoneNumber) {
    const otp = this.generateOTP();
    const formattedPhone = phoneNumber.startsWith('+') ? phoneNumber : `+${phoneNumber}`;

    const params = {
      Message: `Your verification code is: ${otp}. Valid for 5 minutes.`,
      PhoneNumber: formattedPhone,
      MessageAttributes: {
        'AWS.SNS.SMS.SMSType': {
          DataType: 'String',
          StringValue: 'Transactional'
        }
      }
    };

    try {
      const result = await sns.publish(params).promise();
      if (result.MessageId) {
        // Store OTP with expiry
        otpStorage.set(phoneNumber, {
          otp,
          expiry: Date.now() + 5 * 60 * 1000, // 5 minutes
          attempts: 0
        });
        return { success: true, messageId: result.MessageId };
      }
    } catch (error) {
      console.error('SNS Error:', error);
      throw new Error('Failed to send OTP');
    }
  }

  static verifyOTP(phoneNumber, userOTP) {
    const otpData = otpStorage.get(phoneNumber);
    
    if (!otpData) {
      return { valid: false, message: 'OTP not found' };
    }

    if (Date.now() > otpData.expiry) {
      otpStorage.delete(phoneNumber);
      return { valid: false, message: 'OTP expired' };
    }

    if (otpData.attempts >= 3) {
      otpStorage.delete(phoneNumber);
      return { valid: false, message: 'Too many attempts' };
    }

    otpData.attempts++;

    if (otpData.otp === userOTP) {
      otpStorage.delete(phoneNumber);
      return { valid: true, message: 'OTP verified successfully' };
    }

    return { valid: false, message: 'Invalid OTP' };
  }
}

