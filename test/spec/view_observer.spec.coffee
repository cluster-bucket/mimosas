((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../src/mimosas.coffee'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.ViewObserver', ->

    it 'should exist', ->
      expect(Mimosas.ViewObserver).to.exist

    it 'should have a changed event', ->
      observer = new Mimosas.ViewObserver()
      expect(observer.changed).to.exist

    it 'should have a pointer', ->
      observer = new Mimosas.ViewObserver()
      expect(observer.__POINTER__).to.exist
