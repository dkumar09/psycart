var express = require('express');
var router = express.Router();
router.get('/',(req,res)=>{
    req.db.products.findAll().then((data)=>{
        res.render('products',{list:JSON.stringify(data)})
        console.log(JSON.stringify(data));
    }).catch((err)=>{
        console.log(err);
    });
})
router.get('/:productname',(req,res)=>{
    req.db.products.findAll({
        where:{
            url:{
                [req.db.Op.eq]:'/'+req.params.productname+'/'
            }
        }
    }).then((results)=>{
        console.log(results);
        if(results.length >0){
            req.session.productid = results[0].id;
            req.session.url = req.originalUrl;
            res.render('item',{list:JSON.stringify(results)});
        }else{
            res.render('404');
        }
    }).catch((err)=>{
        console.log("error at product route product item handler : ",err);
        res.status(404).render('404');
    })
    
})
module.exports = router;