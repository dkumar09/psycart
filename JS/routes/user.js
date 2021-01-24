var express = require('express');
var router = express.Router();
function checkSignIn(req,res,next){
    if(req.session.user){
        next();
    }else{
        res.redirect('/login');
    }
}
// router.use(function timeLog(req, res, next) {
//     console.log('Time: ', Date.now());
//     next();
// });
router.get('/login',(req,res)=>{
    res.render('login');
});
//signup
router.get('/signup',(req,res)=>{
    res.render('signup');
});

router.get('/logout',(req,res)=>{
    req.session.destroy(()=>{
        console.log("logout");
    });
    res.redirect('/login');
});


router.post('/signup',(req,res)=>{
    return req.db.users.create({
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


//login
router.post('/login',(req,res)=>{
    var username = req.body.username;
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
                    [req.db.Op.eq]: 1
                }
            }
        }).then((results)=>{
            console.log(results[0].id);
            if(results.length > 0){
                req.session.loggedin = true;
                req.session.username  = username;
                req.session.userid = results[0].id;
                if(req.session.url){
                    res.redirect(req.session.url);    
                }else{
                    req.session.url=null;
                    res.redirect('/products')
                };
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

//access gain
router.get("/protected_page",(req,res)=>{
    if(req.session.loggedin){
        res.render('protected_page');
    }else{
        var err = new Error('User Not logged IN');
        console.log(req.session.user);
        res.redirect('login');
    }
});






module.exports = router;