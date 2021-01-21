function placeOrder(sql,callback){
    body={id :4,
        sessionId :123456,
        token :123456,
        status :1,
        subTotal : 100,
        itemDiscount :10,
        tax :50,
        shipping :10,
        total :150,
        promo :null,
        discount :10,
        grandtotal :140,
        firstName :"suraj",
        middleName :null,
        lastName :"kumar",
        mobile :1234567890,
        email :"sk0502@gmail.com",
        line1 :"abc HAll",
        line2 :"NULL",
        city :"delhi",
        province :"delhi",
        country :"india",
        createdAt :"2021-01-21 00:00:00",
        updatedAt :"2021-01-21 00:00:00",
        content:"NULL"};
    query = `INSERT INTO order("userId","sessionId","token","status","subTotal","itemDiscount","tax","shipping","total","promo","discount","grandtotal","firstName","middleName","lastName","mobile","email","line1","line2","city","province","country","createdAt","updatedAt","content") VALUES(${body.id},"${body.sessionId}","${body.token}",${body.status},${body.subTotal},${body.itemDiscount},${body.tax},${body.shipping},${body.total},${body.promo},${body.discount},${body.grandtotal},"${body.firstName}",${body.middleName},"${body.lastName}",${body.mobile},"${body.email}","${body.line1}",${body.line2},"${body.city}","${body.province}","${body.country}",${body.createdAt},${body.updatedAt},${body.content})`;
    sql.query(query,callback);
}
module.exports = {placeOrder:placeOrder};