express = require "express"
app = express()

app.use (req, res, next) ->
	res.header "Access-Control-Allow-Origin", "*"
	next()

app.get "/platforms", (req, res) ->
	res.send [
				{
					id: 0,
					Name: "hello",
					Type: "Yo"
				},
				{
					id: 1,
					Name: "two",
					Type: "Yo"
				},
				{
					id: 2,
					Name: "three",
					Type: "Yo"
				}

			]

app.listen 3001