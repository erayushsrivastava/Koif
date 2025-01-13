const express = require('express');
const authRoutes = require('./routes/auth');
const sendOtp = require("./routes/auth")
const payment = require("./routes/custmorpayment")
const customer = require("./routes/custmer")
const shopowner = require("./routes/shop-owner")
const freelancer = require("./routes/freelancer")
require('dotenv').config();

const app = express();
//const PORT = process.env.PORT || 5000;


app.use(express.json());
app.use('/api/auth', authRoutes);
app.use("/api/sendOtp",sendOtp)
app.use("/api/payment",payment)
app.get('/success', (req, res) => {
    res.send('Payment successful!');
});

app.get('/cancel', (req, res) => {
    res.send('Payment cancelled');
})
app.use("/api/customer/signup", customer);
app.use("/api/customer/signin", customer);

app.use("/api/shopowner/signup", shopowner);
app.use("/api/shopowner/signin", shopowner);

app.use("/api/freelancer/signup", freelancer);
app.use("/api/freelancer/signin", freelancer);


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
