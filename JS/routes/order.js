var express = require('express');
var router = express.Router();
function checkAuth(req,res,next){
    if(req.session.loggedin){
        next();
    }else{
        res.redirect('/login');
    }
}

router.get('/',checkAuth,(req,res)=>{
    res.render('order');
});

router.post('/',checkAuth,(req,res)=>{
    console.log(req.session);
    return req.db.order.create({
        userid:req.session.userid,
        productid:req.session.productid,
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
        res.status(400).send("error");
    });
})

module.exports = router;