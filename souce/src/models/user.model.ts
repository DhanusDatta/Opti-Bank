import * as Sequelize from 'sequelize';

export interface UserAddModel {
    id?: number;
    email: string;
    password: string;
}

export interface UserModel extends Sequelize.Model<UserModel, UserAddModel> {
    id: number;
    email: string;
    password: string;
    createdAt: string;
    updatedAt: string;
}

export const UserModel = (sequelize: Sequelize.Sequelize) =>
    sequelize.define<UserModel, UserAddModel>(
        'user',
        {
            id: {
                type: Sequelize.INTEGER,
                primaryKey: true,
                autoIncrement: true
            },
            email: Sequelize.STRING,
            password: Sequelize.STRING,
        },
        {
            tableName: 'users',
        }
    );