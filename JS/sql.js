var sql  = require('mysql');
const con  = sql.createConnection({
    host:'localhost',
    user:'root',
    database:'psycart'
})
function connect(){
    con.connect((err)=>{
        if(err){
            console.log("Cannot connect to the database",err);
            throw err;
        }else{
            console.log("Connected succesfully");
        }
    })
};
function query(q,callback){
    con.query(q,(err,results,fields)=>{
        if(err) throw err;
        else{
            console.log(results);
        }
        callback(err,results);
    })
}
module.exports={
    connect:connect,
    query:query
};
