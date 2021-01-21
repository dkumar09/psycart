
function plist(sql,callback){
    query = `SELECT * FROM product`;
    sql.query(query,callback);
}
function addProduct(sql,callback){
    con.query(``,(err,results,fields)=>{
        callback(err,results);
    })
    
}
module.exports={
    plist:plist,
    addProduct:addProduct
}