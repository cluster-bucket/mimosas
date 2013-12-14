{spawn, exec} = require 'child_process'
fs = require 'fs'

task "build", "watch and build the Mimosas source", ->
  compiler = spawn 'coffee', ['-cw', 'mimosas.litcoffee']
  compiler.stdout.on 'data', (data) -> console.log data.toString().trim()
  compiler.stderr.on 'data', (data) -> console.error data.toString().trim()

task "test", "test Mimosa agains itself", ->
  reporter = require('nodeunit').reporters.default
  reporter.run ['mimosas.litcoffee']

# Until GitHub has proper Literate CoffeeScript highlighting support, let's
# manually futz the README ourselves.
task "readme", "rebuild the readme file", ->
  source = fs.readFileSync('mimosas.litcoffee').toString()
  source = source.replace /\n\n ([\s\S]*?)\n\n(?! )/mg, (match, code) ->
    "\n```coffeescript\n#{code.replace(/^ /mg, '')}\n```\n"
  fs.writeFileSync 'README.md', source
