path = require 'path'
httpProxy = require('http-proxy')
express = require "express"

apiProxy = httpProxy.createProxyServer()

apiProxy.on 'proxyRes', (proxyRes, req, res) ->
  # deleting www-authenticate to not show browser built-in auth dialog
  delete proxyRes.headers['www-authenticate']

app = express()

app.use(express.static(path.join(__dirname, 'public')))

app.get "/api/*", (req, res)  ->
  req.url = req.url[4..]
  apiProxy.web(req, res, { target: 'http://localhost:3001' })

app.get "*", (req, res) ->
  res.sendFile path.join(__dirname, 'public', 'index.html')

app.listen 3333
