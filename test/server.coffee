connect = require('connect')
path = require('path')

root = path.resolve(__dirname, '../')
host = 'localhost'
port = 8000
app = connect.static(root)

connect.createServer(app).listen port, host, () ->
  console.log "Listening on http://#{host}:#{port}"
