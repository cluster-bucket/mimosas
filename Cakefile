{spawn, exec} = require 'child_process'
fs = require 'fs'

startServer = () ->
  out = fs.openSync('./test/server.log', 'a')
  err = fs.openSync('./test/server.log', 'a')
  server = spawn 'coffee', ['test/server.coffee'],
    detached: true
    stdio: 'ignore', out, err
  server.unref()
  server

task 'build:src', 'build the source', ->
  compiler = spawn 'coffee', ['-o', 'bin/', '-c', 'src/']
  compiler.stdout.on 'data', (data) -> console.log data.toString().trim()
  compiler.stderr.on 'data', (data) -> console.error data.toString().trim()

task 'build:test', 'build tests', ->
  compiler = spawn 'coffee', ['-o', 'test/bin/', '-c', 'test/spec/']
  compiler.stdout.on 'data', (data) -> console.log data.toString().trim()
  compiler.stderr.on 'data', (data) -> console.error data.toString().trim()

# Push the source into the README now that GitHub has property litcoffee support
task "build:readme", "rebuild the readme file", ->
  source = fs.readFileSync('mimosas.litcoffee').toString()
  # source = source.replace /\n\n ([\s\S]*?)\n\n(?! )/mg, (match, code) ->
  #   "\n```coffeescript\n#{code.replace(/^ /mg, '')}\n```\n"
  fs.writeFileSync 'README.md', source

task 'build', 'build test and source', ->
  invoke 'build:src'
  invoke 'build:test'

task 'test:amd', 'test browser AMD', ->
  server = startServer()
  cmd = './node_modules/.bin/mocha-phantomjs --reporter dot http://localhost:8000/test/SpecRunnerGlobals.html'
  exec cmd, (err, stdout, stderr) ->
    console.log 'Browser AMD:'
    if err then console.error stderr else console.log stdout
    server.kill()

task 'test:globals', 'test browser globals', ->
  server = startServer()
  cmd = './node_modules/.bin/mocha-phantomjs --reporter dot http://localhost:8000/test/SpecRunnerGlobals.html'
  exec cmd, (err, stdout, stderr) ->
    console.log 'Browser globals:'
    if err then console.error stderr else console.log stdout
    server.kill()

task 'test:server', 'test server side scripts', ->
  cmd = './node_modules/.bin/mocha --require ./test/helpers/chai.coffee --reporter dot --compilers coffee:coffee-script test/spec/*.spec.coffee'
  exec cmd, (err, stdout, stderr) ->
    console.log 'Exports:'
    if err then console.error stderr else console.log stdout

task 'test', 'test all the things', ->
  invoke 'build'
  invoke 'test:server'
  invoke 'test:globals'
  invoke 'test:amd'

task 'install:components', 'install bower components', ->
  manager = spawn './node_modules/.bin/bower', ['install']
  manager.stdout.on 'data', (data) -> console.log data.toString().trim()
  manager.stderr.on 'data', (data) -> console.error data.toString().trim()

task 'install:modules', 'install node modules', ->
  manager = spawn 'npm', ['install']
  manager.stdout.on 'data', (data) -> console.log data.toString().trim()
  manager.stderr.on 'data', (data) -> console.error data.toString().trim()

task 'install', 'install all dependencies', ->
  invoke 'install:modules'
  invoke 'install:components'
