path = require 'path'
httpProxy = require('http-proxy')
express = require "express"

apiProxy = httpProxy.createProxyServer()

app = express()

app.get "/api/*", (req, res)  ->
  req.url = req.url[4..]
  console.log req.headers

  apiProxy.web(req, res, { target: 'http://localhost:3001' })

app.use(express.static(path.join(__dirname, 'public')));
app.listen 3333