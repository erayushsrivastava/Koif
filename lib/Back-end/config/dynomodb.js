// Load the AWS SDK
const AWS = require('aws-sdk');

// DynamoDB Configuration
const config = {
  region: process.env.AWS_REGION, // Replace with your AWS region
  accessKeyId: process.env.AWS_ACCESS_KEY_ID, // Use environment variables for security
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
};

// Create DynamoDB Service Object
const dynamoDB = new AWS.DynamoDB(config);

// Create DynamoDB Document Client for easier interaction
const docClient = new AWS.DynamoDB.DocumentClient(config);


// Export the clients for use in other files
module.exports = { dynamoDB, docClient };
