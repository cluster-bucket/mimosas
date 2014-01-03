{spawn, exec} = require 'child_process'
fs = require 'fs'


task 'test', 'test all the things', ->
  invoke 'build'
  invoke 'test:globals'
  invoke 'test:amd'

task 'test:globals', 'test browser globals', ->
  testUrl 'http://localhost:8000/test/SpecRunnerGlobals.html'

task 'test:amd', 'test browser AMD', ->
  testUrl 'http://localhost:8000/test/SpecRunnerAMD.html'

task 'clean', 'clean the build directories', ->
  console.log '- Cleaning the build and test directories'
  cmd = 'rm -rf ./bin/* && rm -rf ./test/bin/*'
  exec cmd, (err, stdout, stderr) ->
    if err then console.error stderr else console.log stdout

task 'build', 'build test and source', ->
  invoke 'clean'
  invoke 'build:src'
  invoke 'build:test'

task 'build:src', 'build the source', ->
  console.log '- Building the source files'
  compiler = spawn 'coffee', ['-o', 'bin/', '-c', 'src/']
  compiler.stdout.on 'data', (data) -> console.log data.toString().trim()
  compiler.stderr.on 'data', (data) -> console.error data.toString().trim()

task 'build:test', 'build tests', ->
  console.log '- Building the test files'
  compiler = spawn 'coffee', ['-o', 'test/bin/', '-c', 'test/spec/']
  compiler.stdout.on 'data', (data) -> console.log data.toString().trim()
  compiler.stderr.on 'data', (data) -> console.error data.toString().trim()

task 'server', 'start a server', ->
  server = spawn './node_modules/.bin/coffee', ['./test/server.coffee']
  server.stdout.on 'data', (data) -> console.log data.toString().trim()
  server.stderr.on 'data', (data) -> console.error data.toString().trim()

# Push the source into the README now that GitHub has property litcoffee support
task "build:readme", "rebuild the readme file", ->
  source = fs.readFileSync('mimosas.litcoffee').toString()
  fs.writeFileSync 'README.md', source

testUrl = (url) ->
  console.log "- Testing #{url}"
  server = startServer()
  cmd = "./node_modules/.bin/mocha-phantomjs --reporter dot #{url}"
  exec cmd, (err, stdout, stderr) ->
    console.log stdout
    server.kill()

startServer = () ->
  out = fs.openSync('./test/server.log', 'a')
  err = fs.openSync('./test/server.log', 'a')
  server = spawn 'coffee', ['test/server.coffee'],
    detached: true
    stdio: ['ignore', out, err]
  server.unref()
  server
