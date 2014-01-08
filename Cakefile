{spawn, exec} = require 'child_process'
{EOL} = require 'os'
fs = require 'fs'

Mimosas = require './src/mimosas'

header = """
/**
 * Mimosas v#{Mimosas.VERSION}
 * https://github.com/dustinboston/mimosas
 *
 * Copyright 2013-2014, Dustin boston
 * Released under the GPL License
 */
"""

orderedSourceFiles = [
  'list'
  'iterator'
  'guid'
  'model_subject'
  'controller_context'
  'controller_strategy'
  'view_observer'
  'view_component'
  'view_composite'
  'view_leaf'
  'class'
  'mimosas'
]

browserWrapper = """
  (function(root) {
    var Mimosas = function() {
      function require(path) { return require[path]; }

  {{modules}}

      return require['./mimosas'];
    }();

    if (typeof define === 'function' && define.amd) {
      define(function() { return Mimosas; });
    } else if (typeof exports === 'object') {
      module.exports = Mimosas;
    } else {
      root.Mimosas = Mimosas;
    }
  }(this));
"""

moduleWrapper = """
  require['./{{file}}'] = (function() {
    var exports = {}, module = {exports: exports};

  {{module}}

    return module.exports;
  })();\n\n
"""

task 'test', 'test all the things', ->
  console.log '- Running unit tests'
  invoke 'build'

task 'build', 'build test and source', ->
  invoke 'clean'
  buildSource ->
    invoke 'build:browser'
    invoke 'build:doc'
  buildTests()

task 'build:browser', 'rebuild the merged script for inclusion in the browser', ->
  modules = ''
  for file in orderedSourceFiles
    js = fs.readFileSync "bin/#{file}.js"
    js = pad js, '  '
    wrapped = moduleWrapper.replace '{{module}}', js
    wrapped = wrapped.replace '{{file}}', file
    modules += wrapped
  modules = pad modules, '    '
  output = browserWrapper.replace '{{modules}}', modules
  output = output.replace /^\s*$/gm, ''
  fs.writeFileSync 'mimosas.js', header + '\n' + output
  console.log "built"

task 'build:doc', 'generate API documentation', ->
  console.log '- Generating API documentation'
  cmd = "./node_modules/.bin/codo --name #{Mimosas.NAME} "
  cmd += "--title '#{Mimosas.NAME} API Documentation' ./src/*"
  executeCommand cmd

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


# Build from source.
buildSource = (cb) ->
  files = fs.readdirSync 'src'
  files = ('src/' + file for file in files when file.match(/\.(lit)?coffee$/))
  run ['-cb', '-o', 'bin'].concat(files), cb

buildTests = (cb) ->
  files = fs.readdirSync 'test/spec'
  files = ('test/spec/' + file for file in files when file.match(/\.(lit)?coffee$/))
  run ['-c', '-o', 'test/bin'].concat(files), cb

# Run CoffeeScript
run = (args, cb) ->
  proc = spawn './node_modules/.bin/coffee', args
  proc.stderr.on 'data', (buffer) -> console.log buffer.toString()
  proc.on 'exit', (status) ->
    process.exit(1) if status != 0
    cb() if typeof cb is 'function'

pad = (str, pad) ->
  if pad then pad + String(str).split(EOL).join(EOL + pad) else str

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

