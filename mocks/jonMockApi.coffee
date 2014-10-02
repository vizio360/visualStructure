express = require "express"
fs = require "fs"
auth = require "http-auth"
basic = auth.basic 
           realm: "JON Mock API",
           file: __dirname + "/users.htpasswd"

app = express()

app.use (req, res, next) ->
  res.header "Access-Control-Allow-Methods", "GET,PUT,POST,DELETE,OPTIONS"
  res.header "Access-Control-Allow-Headers", "Content-Type, Authorization, Content-Length, X-Requested-With"
  res.header "Access-Control-Allow-Origin", "*"
  if req.method == "OPTIONS"
    res.status(200).end()
  else
    next()

app.use auth.connect(basic)


app.get "/", (req, res) ->
  res.send 200

app.get "*", (req, res) ->
  url = req.url[1..]
  parts = url.replace("/", "_")
  data = fs.readFileSync "jonAPIdata/#{parts}.json", { encoding: 'utf8'}
  res.send data

app.listen 3001