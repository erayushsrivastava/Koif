const express = require('express');
const connectDB = require('./config/db');
const authRoutes = require('./routes/auth');
require('dotenv').config();

const app = express();
//const PORT = process.env.PORT || 5000;

connectDB();

app.use(express.json());
app.use('/api/auth', authRoutes);


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
