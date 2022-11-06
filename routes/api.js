var express = require("express");
const {
    verifyUser,
    verifyUserSecure,
    loginWithCredentials,
    getUserDetails,
    updateBalancesAndRecord,
} = require("../services/dbFunctions");
const sendRequest = require("../services/sendRequest");
var router = express.Router();
const createError = require("http-errors");
const checkAuth = require("../middlewares/checkAuth");
const request = require('request');



router.post("/verify-credentials", async (req, res, next) => {
    const { username, password } = req.body;
    const { secure } = req.query;

    if (!username || !password) {
        return res.status(400).json({
            message: "Bad Request",
        });
    }

    try {
        if (secure == "yes") {
            const userDetails = await verifyUserSecure(username, password);
            return res.status(200).json(userDetails[0]);
        }

        const userDetails = await verifyUser(username, password);
        return res.status(200).json(userDetails);
    } catch (err) {
        console.log(err);

        return res.sendStatus(500);
        // res.status(500).json
    }
});

router.post("/login-user", async (req, res, next) => {
    const { acc_no, password } = req.body;
    const { secure } = req.query;

    if (!acc_no || !password) {
        return res.status(400).json({
            message: "Bad Request",
        });
    }

    try {
        const userDetails = await loginWithCredentials(acc_no, password);

        req.session.regenerate(function (err) {
            if (err) {
                next(createError(500));
            }

            // store user information in session, typically a user id
            req.session.acc_no = acc_no;

            // save the session before redirection to ensure page
            // load does not happen before session is saved
            req.session.save(function (err) {
                if (err) {
                    return next(createError(500));
                }
                return res.status(200).json({
                    message: "Success",
                });
            });
        });
    } catch (err) {
        console.log(err);
        return res.status(500).json({
            message: err,
        });
    }
});

const csrfProt = require("../middlewares/csrfProt"); // off CSRF

router.get("/transfer/:to_acc_no/:amount", csrfProt, checkAuth, async (req, res, next) => { // off CSRF
// router.get("/transfer/:to_acc_no/:amount", checkAuth, async (req, res, next) => { // on CSRF
    let { to_acc_no, amount } = req.params;
    let from_acc_no = req.session?.acc_no;

    from_acc_no = parseInt(from_acc_no);
    to_acc_no = parseInt(to_acc_no);
    amount = parseFloat(amount);

    if (
        isNaN(from_acc_no) ||
        isNaN(to_acc_no) ||
        isNaN(amount) ||
        from_acc_no <= 0 ||
        to_acc_no <= 0 ||
        amount <= 0 ||
        from_acc_no == to_acc_no
    ) {
        return res.status(400).json({
            message: "Bad Request",
        });
    }

    try {
        const [sender, receiver] = await Promise.all([
            getUserDetails(from_acc_no),
            getUserDetails(to_acc_no),
        ]);

        if (sender.balance < amount) {
            return res.status(500).json({
                message: "Insufficent Funds",
            });
        }

        const id = await updateBalancesAndRecord(
            from_acc_no,
            to_acc_no,
            amount
        );

        return res.status(200).json({
            message: `Transfer successful with<br>reference id = ${id}<br>
                Available balance = ${sender.balance - amount}`,
        });
        
    } catch (err) {
        console.log(err);
        return res.status(500).json({
            message: err,
        });
    }
});


router.post("/verify-credentials", async (req, res, next) => {
    const { username, password } = req.body;
    const { secure } = req.query;

    if (!username || !password) {
        return res.status(400).json({
            message: "Bad Request",
        });
    }

    try {
        if (secure == "yes") {
            const userDetails = await verifyUserSecure(username, password);
            return res.status(200).json(userDetails[0]);
        }

        const userDetails = await verifyUser(username, password);
        return res.status(200).json(userDetails);
    } catch (err) {
        console.log(err);

        return res.sendStatus(500);
        // res.status(500).json
    }
});

router.post("/spam/predict", async (req, res, next) => {
    const { text } = req.body;

    if (!text) {
        return res.status(400).json({
            message: "Bad Request",
        });
    }

    var options = {
        url: 'http://localhost:8000/spam/predict',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        form: { 'text' : text }
    }

    try {
        request(options, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                // Print out the response body
                // console.log(body)
                body = JSON.parse(body);

                return res.status(200).json(body);
            }
            console.error(error);
            throw error;
        })

    } catch (err) {
        console.log(err);
        return res.status(500).json({
            message: err,
        });
    }
});

module.exports = router;
