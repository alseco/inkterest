'use strict'

const express = require('express')
const mysql = require('mysql')
const app = express()
const path = require('path')
const session = require('express-session')
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(express.static(__dirname + "/images"))
app.use(express.static(__dirname + "/style"))
app.use(express.static(__dirname + "/lib"))

app.use(session({
    resave: false,
    saveUninitialized: true,
    secret: 'secret',
}));

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: ' ',
    database: 'inkterest'
})

connection.connect((err) => {
  if (!err) {
    console.log('Database connected...')
  } else {
    console.log('Error connecting to database...')
    console.log(err);
  }
})

var auth = (req, res, next) => {
    if (req.session && req.session.username)
        return next();
    else
        return res.send('Forbidden. Needs authentication');
}

app.post('/login', function(req, res) {
    connection.query('select * from user where username = BINARY ? and password = BINARY ?', [req.body.uname, req.body.pw], function(err, rows, fields) {
        if (!err) {
            if(rows[0]){
                req.session.username = req.body.uname
                res.json({
                    redirect: '/home'
                })
            }
            else{
                res.json({
                    redirect: '/'
            })
            }
        }
        else{
            throw err
        }
    })
})

app.get('/logout',function(req,res){
   req.session.destroy(function(err){
        res.json({
            redirect: '/'
        })
    })
})

app.post('/inkterest/user_insert', function(req, res) {
  let newUser = {
    email: req.body.email,
    username: req.body.username,
    password: req.body.password,
    following_count:0,
    follower_count:0,
    likes :0
  }

  connection.query('INSERT INTO user SET ?', newUser, function(err, rows, fields) {
    if (err) {
       return res.status(500).send({message: 'Username is already taken.'});
    }
    else {
      return res.send({message: 'Successfully signed up!'});
    }
  })

})

app.get('/', function(req, res){
    if(req.session.username){
        res.redirect('/home')
    }else
        res.sendFile(__dirname + '/login.html')
})

app.use(auth);


app.get('/getUserName', function(req, res){
    res.send({username: req.session.username})
})

app.get('/inkterest/me/post/topics', function(req, res) {
    connection.query('select * from topic', function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post/boards/', function(req, res) {
    connection.query('select * from board',function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post/boards/:name', function(req, res) {
    connection.query('select * from board where username = ?', req.params.name,function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})


app.get('/inkterest/search/', function(req, res) {
    connection.query('select * from pin', function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/search/:filter', function(req, res) {
    connection.query('select * from pin where content like ? or topic_name like ? or username like ?', ['%' + req.params.filter + '%', '%' + req.params.filter + '%', '%' + req.params.filter + '%'], function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/initFeed/', function(req, res) {
    connection.query('select * from pin username', function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/initFeed/:filter', function(req, res) {
    connection.query('select * from pin where username in (select following_username from userfollowers where follower_username = ?) order by time_of_post desc', req.params.filter, function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})


app.get('/inkterest/me/', function(req, res) {
    connection.query('select * from user',function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/:filter', function(req, res) {
    connection.query('select * from user where username = ?', req.params.filter,function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post/', function(req, res) {
    connection.query('select * from pin',function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post/:filter', function(req, res) {
    connection.query('select * from pin where username = ? order by time_of_post', req.params.filter,function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post-by-board/', function(req, res) {
    connection.query('select * from pin',function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.get('/inkterest/me/post-by-board/:filter/:board', function(req, res) {
    console.log(req.params.board)
    console.log(req.params.filter)
    connection.query('select * from pin where username = ? and board_name = ? order by time_of_post desc', [req.params.filter, req.params.board],function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.delete('/inkterest/me/post/delete/:filter', function(req, res) {
    connection.query('delete from pin where pin_id = ?', req.params.filter,function(err, rows, fields) {
        if (!err) {
          res.send(rows)
        }
    })
})

app.put('/inkterest/me/post/edit/:postUpdate', function(req, res){
    var newPost = {
        content: req.body.content,
        topic_name: req.body.topic_name
    }

    connection.query('update pin set ? where pin_id = ?', [newPost, req.params.postUpdate], function(err, rows, fields) {
        if (err){
            console.log(err)
        }else {
            res.send()
        }
    })
})

app.put('/inkterest/me/editInfo/:username', function(req, res){
    console.log(req.body);
    var newDetails = {
       email: req.body.email,
       username: req.body.username,
       password: req.body.password,
    }

    connection.query('update user set ? where username = ?', [newDetails, req.params.username], function(err, rows, fields) {
       if (err) {
        return res.status(500).send({message: 'Invalid input'});
        }
        else {
        req.session.username=newDetails.username
        return res.send({message: 'Successfully ediited information!'});
        }
    })
})

app.put('/inkterest/incotherLike/:pin_id', function(req, res){
    console.log(req.body);
    console.log(req.params.pin_id)

    connection.query('update pin set likes = ? where pin_id = ?', [req.body.likes,req.params.pin_id], function(err, rows, fields) {
       if (err) {
        return res.status(500).send({message: err});
        }
        else {
        return res.send({message: 'Someone liked it!'});
        }
    })
})

app.put('/inkterest/incmyLike/:username', function(req, res){
    connection.query('update user set user.likes = ? where username = ?', [req.body.likes, req.params.username], function(err, rows, fields) {
       if (err) {
        return res.status(500).send({message: err});
        }
        else {
        return res.send({message: 'Successfully liked!'});
        }
    })
})

app.put('/inkterest/incotherLike/:pin_id', function(req, res){
    console.log(req.body);
    var newDetails = {
       likes: req.body.likes+1,
    }
    console.log(newDetails);
    console.log(req.params.pin_id)

    connection.query('update pin set ? where username = ?', [newDetails, req.params.pin_id], function(err, rows, fields) {
       if (err) {
        return res.status(500).send({message: err});
        }
        else {
        return res.send({message: 'Someone liked it!'});
        }
    })
})

app.put('/inkterest/incmyLike/:username', function(req, res){
      var newDetails = {
       likes: req.params.username.likes+1,
    }
    connection.query('update pin set ? where username = ?', [newDetails.likes, req.params.username], function(err, rows, fields) {
       if (err) {
        return res.status(500).send({message: err});
        }
        else {
        return res.send({message: 'Successfully liked!'});
        }
    })
})


app.get('/inkterest/followers/:filter', function(req, res) {
    connection.query('select count(follower_username) as count from userfollowers where following_username = ?', req.params.filter,function(err, rows, fields) {
        if (!err) {
            console.log(rows);
          res.send(rows[0])
        }
    })
})

app.get('/inkterest/boardno/:filter', function(req, res) {
    connection.query('select count(board_name) as count from board where username= ?', req.params.filter,function(err, rows, fields) {
        if (!err) {
            console.log(rows);
          res.send(rows[0])
        }
    })
})

app.get('/inkterest/following/:filter', function(req, res) {
    connection.query('select count(following_username) as count from userfollowers where follower_username = ?', req.params.filter,function(err, rows, fields) {
        if (!err) {
            console.log(rows);
          res.send(rows[0])
        }
    })
})

app.post('/inkterest/me/post/add/:username', function(req, res){
    connection.query('INSERT INTO pin (`content`,`time_of_post`,`username`,`board_name`,`topic_name`,`likes`) values(?,?,?,?,?,?)',[req.body.content,'now()',req.params.username,req.body.board_name,req.body.topic_name,0], function(err, rows, fields) {
        if (err){
            console.log(err)
        }else {
            res.send()
        }
    })
})

app.post('/inkterest/me/create-board/:username/:board', function(req, res){
    connection.query('insert into board values(?, ?)',[req.params.username, req.params.board], function(err, rows, fields) {
        if (err){
            console.log(err)
        }else {
            res.send()
        }
    })
})


app.get('/home', function(req, res) {
    res.sendFile(__dirname + '/home.html')
})

app.get('/profile', function(req, res) {
    res.sendFile(__dirname + '/profile.html')
})


app.listen(3000)