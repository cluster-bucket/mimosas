((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/view_leaf', '../../bin/view_component', '../../bin/view_observer'], factory
    return
  else if typeof exports is 'object'
    ViewLeaf = require '../../src/view_leaf.coffee'
    ViewComponent = require '../../src/view_component.coffee'
    ViewObserver = require '../../src/view_observer.coffee'
    module.exports = factory ViewLeaf, ViewComponent, ViewObserver
    return
  else
    ViewLeaf = root.Mimosas.ViewLeaf
    ViewComponent = root.Mimosas.ViewComponent
    ViewObserver = root.Mimosas.ViewObserver
    factory ViewLeaf, ViewComponent, ViewObserver
    return
) @, (ViewLeaf, ViewComponent, ViewObserver) ->

  describe 'ViewLeaf', ->
    
    leaf = undefined
    
    beforeEach ->
      leaf = new ViewLeaf('#fixture')
      
    afterEach ->
      leaf = undefined

    it 'should exist', ->
      expect(ViewLeaf).to.exist

    # BUG: doesn't work with AMD
    #it 'should be an instance of ViewComponent', ->
      #expect(leaf).to.be.an.instanceof ViewComponent

    #it 'should be an instance of ViewObserver', ->
      #expect(leaf).to.be.an.instanceof ViewObserver
  
    it 'should set a parent', ->
      leaf.setParent 'foo'
      expect(leaf.parent).to.equal 'foo'
      
    it 'should get a parent', ->
      leaf.setParent 'bar'
      expect(leaf.getParent()).to.equal 'bar'