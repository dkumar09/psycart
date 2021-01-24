var express = require('express');
var bodyParser = require('body-parser');
var product = require('./JS/products');
var order = require("./JS/routes/order");
var sql = require('./JS/sql');
var db = require('./JS/db');
var multer = require('multer');
var cookieParser = require('cookie-parser');
var session = require('express-session')
var app  = express();
var router = express.Router();
//Initialize the database
db.db();

//setting the templating engine
app.set('view engine', 'pug');
app.set('views','./views')

//middleware to be used to attach db object to request object
app.use((req,res,next)=>{
    req.db = db;
    next();
});

//parsing the form data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//managing the session
//encrypted storage so no issue
app.use(session({
    secret: "psykey",
    resave:true,
    saveUninitialized:true
}));
//manages the basic user functionality login logout
app.use(require("./JS/routes/user"));
//manages the product routes
app.use('/products',require("./JS/routes/products"));
//admin functions
app.use('/admin',require("./JS/routes/admin"));
// orders
app.use('/order', require('./JS/routes/order'));

app.get('/image/:id',(req,res)=>{
    res.sendFile(__dirname+'/images/a.svg');
});

function checkSignIn(req,res){
    if(req.session.user){
        next();
    }else{
        var err = new Error('User Not logged IN');
        console.log(req.session.user);
        next(err);
    }
}

// API to be developed later
// router.get('/',(req,res)=>{
//     res.send("hola amigos");
// })
// router.get('/products',(req,res)=>{
//     db.products.findAll().then((data)=>{
//         res.send(data);
//         console.log(data);
//     }).catch((err)=>{
//         console.log(err);
//     });
// });
// app.use('/api',router);
app.listen(8080,()=>{
    console.log("listening on port 8080")
})