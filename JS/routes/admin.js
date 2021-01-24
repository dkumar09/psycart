var express = require('express');
var router = express.Router();

function checkAuth(req,res,next) {
    if(req.session.loggedin && req.session.admin){
        console.log("auth granted");
        next();
    }else{
        res.redirect('/admin/login');
    }
}


router.get('/login',(req,res)=>{
    res.render('alogin');
});

router.get('/logout',(req,res)=>{
    req.session.destroy(()=>{
        console.log("logout");
    });
    res.redirect('/login');
});


router.post('/login',(req,res)=>{
    var username = req.body.id;
    var password = req.body.password;
    if(username && password){
        //apply req.db logic
        req.db.users.findAll({
            where:{
                username:{
                    [req.db.Op.eq]:username
                },
                password:{
                    [req.db.Op.eq]:password 
                },
                admin:{
                    [req.db.Op.eq]:true
                }
            }
        }).then((results)=>{
            console.log(results);
            if(results){
                req.session.loggedin = true;
                req.session.username  = username;
                req.session.admin = true;
                res.redirect('/admin/protected_page')
            }else{
                res.render('alogin',{message:"invalid creds"});
            }
        }).catch((err)=>{
            console.log(err);
            res.render('alogin',{message:"invalid creds"});
        });
    }else{
        res.render('alogin',{message:"invalid creds"});
    }
});
//access gain
router.get('/protected_page',checkAuth,(req,res)=>{
    res.render('protected_page')
});
module.exports = router;