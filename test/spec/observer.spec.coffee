((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/observer'], factory
  else if typeof exports is 'object'
    Observer = require '../../src/observer.coffee'
    module.exports = factory Observer
  else
    Observer = root.Mimosas.Observer
    factory Observer
) @, (Observer) ->

  describe 'Observer', ->

    it 'should exist', ->
      expect(Observer).to.exist
  
    it 'should have a changed event', ->
      observer = new Observer()
      expect(observer.changed).to.exist