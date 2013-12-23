((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/view_observer'], factory
    return
  else if typeof exports is 'object'
    ViewObserver = require '../../src/view_observer.coffee'
    module.exports = factory ViewObserver
    return
  else
    ViewObserver = root.Mimosas.ViewObserver
    factory ViewObserver
    return
) @, (ViewObserver) ->

  describe 'ViewObserver', ->

    it 'should exist', ->
      expect(ViewObserver).to.exist
  
    it 'should have a changed event', ->
      observer = new ViewObserver()
      expect(observer.changed).to.exist
      
    it 'should have a pointer', ->
      observer = new ViewObserver()
      expect(observer.__POINTER__).to.exist