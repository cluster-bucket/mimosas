{spawn, exec} = require 'child_process'
fs = require 'fs'

PROJECT_NAME = 'Mimosas'

task 'clean', 'clean the build directories', ->
  console.log '- Cleaning build directories'
  invoke 'clean:bin'
  invoke 'clean:testbin'
  invoke 'clean:coverage'

task 'clean:bin', 'clean the bin directory', ->
  console.log '- Cleaning bin directory'
  executeCommand 'rm -rf ./bin/*'

task 'clean:testbin', 'clean the test/bin directory', ->
  console.log '- Cleaning test/bin directory'
  executeCommand 'rm -rf ./test/bin/*'

task 'clean:coverage', 'clean the coverage directory', ->
  console.log '- Cleaning test/coverage directory'
  cmd = ['rm -f ./test/coverage/index.html', 'rm -rf ./test/coverage/instrumented/*']
  executeCommand cmd.join(' && ')



task 'test', 'test all the things', ->
  console.log '- Running unit tests'
  invoke 'build'
  invoke 'test:globals'
  invoke 'test:amd'

task 'test:globals', 'test browser globals', ->
  testUrl 'http://localhost:8000/test/SpecRunnerGlobals.html'

task 'test:amd', 'test browser AMD', ->
  testUrl 'http://localhost:8000/test/SpecRunnerAMD.html'



task 'build', 'build test and source', ->
  invoke 'clean'
  invoke 'build:src'
  invoke 'build:test'
  invoke 'build:doc'

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

task 'build:doc', 'generate API documentation', ->
  console.log '- Generating API documentation'
  cmd = "./node_modules/.bin/codo --name #{PROJECT_NAME} "
  cmd += "--title '#{PROJECT_NAME} API Documentation' ./src/*"
  executeCommand cmd

task 'build:instrument', 'instrument code for coverage reports', ->
  console.log '- Instrumenting code for coverage reports'
  unless fs.existsSync './test/coverage'
    fs.mkdir './test/coverage'

  unless fs.existsSync './test/coverage/instrumented'
    fs.mkdir './test/coverage/instrumented'

  cmd = 'jscoverage ./bin/ ./test/coverage/instrumented/'
  exec cmd, (err, stdout, stderr) ->
    if err then console.error stderr else console.log stdout
    invoke 'build:coverage'

task 'build:coverage', 'generate code coverage report from instrumented code', ->
  console.log '- Generating code coverage report'
  cmd = './node_modules/.bin/mocha-browser ./test/SpecRunnerGlobalsCoverage.html -SR html-cov > ./test/coverage/index.html'
  executeCommand cmd

# Push the source into the README now that GitHub has property litcoffee support
task "build:readme", "rebuild the readme file", ->
  source = fs.readFileSync('mimosas.litcoffee').toString()
  fs.writeFileSync 'README.md', source



task 'server', 'start a server', ->
  server = spawn './node_modules/.bin/coffee', ['./test/server.coffee']
  server.stdout.on 'data', (data) -> console.log data.toString().trim()
  server.stderr.on 'data', (data) -> console.error data.toString().trim()



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

executeCommand = (cmd) ->
  console.log "- Running command #{cmd}"
  exec cmd, (err, stdout, stderr) ->
    if err then console.error stderr else console.log stdout

