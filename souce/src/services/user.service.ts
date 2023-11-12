import { User } from "../helpers/sequelize.helper";

export class UserService {
    all({email, password}: any) {
        return User.findAll().then((users) => {
            return {users};
        })
    }

    register({email, password}: any) {
        return User.create({email: email, password: password}).then((user) => {
            return {message: "Registration Successful", user};
        })
    }
}