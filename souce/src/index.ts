import express from 'express'
import { UserService } from './services/user.service';
import bodyParser from 'body-parser';

const app = express()
app.use(bodyParser.json());

const userService = new UserService()

app.listen(5000, () => {
    console.log("App is running");
})

app.get('/hello', (req, res) => {
    console.log("Hello, world!");
    res.send("Hello world");
})

app.post('/register', (req, res) => {
    const user = userService.register(req.body);
    user.then((u) => {res.json(u)})
})

app.post('/all', (req, res) => {
    console.log(req.body);
    const user = userService.register(req.body);
})