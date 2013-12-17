'use strict'

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: '**/*.coffee'
            dest: 'bin/'
            ext: '.js'
          }
          {
            expand: true
            cwd: 'test/spec/'
            src: '**/*.coffee'
            dest: 'test/bin/'
            ext: '.js'
          }
        ]
        options:
          bare: false

    connect:
      test:
        options:
          port: '?'
          base: '.'
          hostname: '*'

    jasmine:
      browserGlobals:
        src: ['bin/**/*.js']
        options:
          outfile: '_SpecRunnerGlobal.html'
          specs: 'test/bin/**/*.js'

      browserAMD:
        src: ['bin/**/*.js']
        options:
          specs: 'test/bin/**/*.js'
          template: require 'grunt-template-jasmine-requirejs'
          templateOptions:
            requireConfig:
              baseUrl: 'bin/'

    jasmine_node:
      verbose: true
      projectRoot: '.'
      match: '.'
      specNameMatcher: 'spec'
      specFolders: ['test/spec']
      extensions: 'coffee'
      useCoffee: true
      useHelpers: false
      forceExit: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-jasmine-node'

  # grunt.registerTask 'test', ['coffee', 'connect:test', 'jasmine']
  grunt.registerTask 'test', ['coffee', 'jasmine_node']
