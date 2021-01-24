const { Sequelize , DataTypes, Op } = require('sequelize');
const sequelize = new Sequelize('shop', 'root', '', {
    host: 'localhost',
    dialect: 'mariadb'
  });
const users = sequelize.define('users',{
    id:{
        type:DataTypes.BIGINT,
        allowNull:false,
        primaryKey:true,
        autoIncrement:true
    },
    username:{
        type:DataTypes.STRING(50),
        allowNull:false,
        unique:true
    },
    email:{
        type:DataTypes.STRING(50),
        allowNull:false,
        unique:true
    },
    password:{
        type:DataTypes.STRING(32),
        allowNull:false
    },
    admin:{
        type:DataTypes.BOOLEAN,
        allowNull:false,
        defaultValue:false
    }

}) 
const products = sequelize.define('products',{
    id:{
        type:DataTypes.BIGINT,
        allowNull:false,
        primaryKey:true,
        autoIncrement:true
    },
    name:{
        type:DataTypes.STRING(50),
        allowNull:false
    },
    rating:{
        type:DataTypes.FLOAT,
        allowNull:false
    },
    price:{
        type:DataTypes.FLOAT,
        allowNull:false
    },
    img_url:{
        type:DataTypes.STRING(100),
        allowNull:false
    },
    url:{
        type:DataTypes.STRING(100),
        allowNull:false,
        unique:true
    },
    category:{
        type:DataTypes.BIGINT,
        allowNull:true,
        defaultValue:true,
    }
    },{indexes:[{
        unique:true,
        fields:['category']
    }]
});
const product_categories = sequelize.define("product_categories",{
    idcategory:{
        type:DataTypes.BIGINT,
        allowNull:false,
        autoIncrement:true,
        primaryKey:true
    },
    categoryname:{
        type:DataTypes.STRING(50),
        allowNull:false,
    }
})
const order = sequelize.define("orders",{
    id:{
        type:DataTypes.BIGINT,
        allowNull:false,
        autoIncrement:true,
        primaryKey:true
    },
    userid:{
        type:DataTypes.BIGINT,
        allowNull:false
    },
    productid:{
        type:DataTypes.BIGINT,
        allowNull:false
    }
})
order.belongsTo(users,{foreignKey:"userid",targetKey:"id"})
async function db(){
    try{
        await sequelize.sync({ force: false });
        console.log("model initialized")
    }catch(err){
        console.log(err);
    }
};
module.exports = {
    order:order,
    users:users,
    product_categories:product_categories,
    products:products,
    sequelize:sequelize,
    Op:Op,
    db:db
}
