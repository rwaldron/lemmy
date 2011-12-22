express = require 'express'

app = express.createServer()

app.configure ->
  app.use express.logger()
  app.use express.methodOverride()
  app.use express.bodyParser()
  app.use express.router()
  return

app.configure 'development', ->
  app.use express.errorHandler(
    dumpExceptions: true,
    showStack: true
  )
  return

app.listen 3000
