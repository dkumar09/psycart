var express = require('express');
var bodyParser = require('body-parser');
var product = require('./JS/products');
var order = require("./JS/order");
var sql = require('./JS/sql');
var db = require('./JS/db');
var multer = require('multer');
var cookieParser = require('cookie-parser');
var session = require('express-session')
var app  = express();
var router = express.Router();

app.set('view engine', 'pug');
app.set('views','./views')
db.db();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
    secret: "psykey",
    resave:true,
    saveUninitialized:true
}));
app.use(require("./JS/routes"));
function checkSignIn(req,res){
    if(req.session.user){
        next();
    }else{
        var err = new Error('User Not logged IN');
        console.log(req.session.user);
        next(err);
    }
}

app.get('/login',(req,res)=>{
    res.render('login');
});
var Users=[];

//signup
app.get('/signup',(req,res)=>{
    res.render('signup');
})
app.post('/signup',(req,res)=>{
    return db.users.create({
        username:req.body.username,
        email:req.body.email,
        password:req.body.password,
        createdAt:new Date(Date.now()).toISOString(),
        updatedAt:null
        }
    ).then((users)=>{
        if(users){
            console.log(users);
            res.render('login');
        }else{
            res.status(400).send("error");
        }
    }).catch((err)=>{
        console.log(err);
    }); 
});
//access gain
app.get("/protected_page",(req,res)=>{
    if(req.session.loggedin){
        res.render('protected_page');
    }else{
        var err = new Error('User Not logged IN');
        console.log(req.session.user);
        res.redirect('login');
    }
});

//login
app.post('/login',(req,res)=>{
    var username = req.body.id;
    var password = req.body.password;
    if(username && password){
        //apply db logic
        db.users.findAll({
            where:{
                username:{
                    [db.Op.eq]:username
                },
                password:{
                    [db.Op.eq]:password 
                }
            }
        }).then((results)=>{
            if(results){
                req.session.loggedin = true;
                req.session.username  = username;
                res.redirect('/protected_page')
            }else{
                res.render('login',{message:"invalid creds"});
            }
        }).catch((err)=>{
            console.log(err);
            res.render('login',{message:"invalid creds"});
        });
    }else{
        res.render('login',{message:"invalid creds"});
    }
});

app.get('/logout',(req,res)=>{
    req.session.destroy(()=>{
        console.log("logout");
    });
    res.redirect('/login');
});

//products
app.get('/products',(req,res)=>{
    db.products.findAll().then((data)=>{
        res.render('products',{list:JSON.stringify(data)})
        console.log(JSON.stringify(data));
    }).catch((err)=>{
        console.log(err);
    });
})
app.get('/products/:productname',(req,res)=>{
    console.log(req.params);
    res.send(req.params.productname);
})
//order
app.get('/order',(req,res)=>{
    res.render('order')
})
app.post('/order',(req,res)=>{
    return db.order.create({
        userid:req.body.userid,
        productid:req.body.productid,
        createdAt:new Date(Date.now()).toISOString(),
        updatedAt:null
        }
    ).then((users)=>{
        if(users){
            console.log(users);
            res.redirect("/products");
        }else{
            res.status(400).send("error");
        }
    }).catch((err)=>{
        console.log(err);
    });
})



router.get('/',(req,res)=>{
    res.send("hola amigos");
})
router.get('/products',(req,res)=>{
    db.products.findAll().then((data)=>{
        res.send(data);
        console.log(data);
    }).catch((err)=>{
        console.log(err);
    });
});
app.use('/api',router);
app.listen(8080,()=>{
    console.log("listening on port 8080")
})