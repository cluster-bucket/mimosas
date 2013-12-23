((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/view_component', '../../bin/view_observer'], factory
    return
  else if typeof exports is 'object'
    ViewComponent = require '../../src/view_component.coffee'
    ViewObserver = require '../../src/view_observer.coffee'
    module.exports = factory ViewComponent, ViewObserver
    return
  else
    ViewComponent = root.Mimosas.ViewComponent
    ViewObserver = root.Mimosas.ViewObserver
    factory ViewComponent, ViewObserver
    return
) @, (ViewComponent, ViewObserver) ->

  describe 'ViewComponent', ->

    component = undefined

    beforeEach ->
      component = new ViewComponent('#fixture')
      
    afterEach ->
      component = undefined

    it 'should exist', ->
      expect(ViewComponent).to.exist
  
    # BUG: doesn't work with AMD
    #it 'should be an instance of ViewObserver', ->
      #expect(component).to.be.an.instanceof ViewObserver
  
    it 'should set a parent', ->
      component.setParent 'foo'
      expect(component.parent).to.equal 'foo'
      
    it 'should get a parent', ->
      component.setParent 'bar'
      expect(component.getParent()).to.equal 'bar'