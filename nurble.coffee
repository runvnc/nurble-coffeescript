fs = require 'fs'
express = require 'express'
app = express()

app.use express.bodyParser()
app.use app.router
app.use express.static(__dirname + '/public')
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

nouns = fs.readFileSync('nouns.txt', 'utf8').split('\n')

nurble = (text) ->
  text = text.toUpperCase()
  words = text.toLowerCase().replace(/[^a-z ]/g, '').split(' ')

  for word in words
    if word not in nouns
      re = new RegExp "(\\b)#{word}(\\b)","i"
      replacement = '$1<span class="nurble">nurble</span>$2'
      text = text.replace re, replacement

  text.replace  /\n/g, '<br>'

app.get '/', (req, res) ->
  res.render 'index'

app.post '/nurble', (req, res) ->
  res.render 'nurble', {nurble: nurble req.body.text}

app.listen 3005
