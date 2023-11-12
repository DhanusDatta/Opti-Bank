import { UserModel } from "../models/user.model";
import { Sequelize } from 'sequelize';

const db = "mysql://root:@localhost:3306/grocery_app?serverTimezone=Asia/Kolkata"

const sequelize = new Sequelize(db, {
    dialect: 'mysql',
    timezone: '+05:30'
});

const User = UserModel(sequelize);

export {User}