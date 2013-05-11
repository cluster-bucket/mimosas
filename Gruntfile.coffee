module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Compiles CoffeeScript files in place, with the wrappers
    coffee:
      src:
        options:
          bare: false
          join: true
        files:
          'dist/mimosas.js': [
            'src/list.litcoffee'
            'src/iterator.litcoffee'
            'src/concrete_iterator.litcoffee'
            'src/subject.litcoffee'
            'src/observer.litcoffee'
            'src/mimosas.litcoffee'
          ]

      example:
        files: [
          expand: true
          cwd: 'example/'
          src: '**/*.litcoffee'
          dest: 'example'
          ext: '.js'
        ]
        options:
          bare: false

    requirejs:
      src:
         options:
          keepBuildDir: true
          appDir: 'tmp'
          baseUrl: './'
          dir: 'dist'
          removeCombined: true
          optimize: 'none'
          optimizeCss: 'none'
          preserveLicenseComments: true
          modules: [
            name: 'mimosas'
            include: []
          ]
    
    connect:
      server:
        port: 8080
        base: '.'
        keepalive: true

  # Load tasks
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  # Register custom tasks
  grunt.registerTask 'default', ['coffee']
  grunt.registerTask 'server', ['default', 'connect:server:keepalive']