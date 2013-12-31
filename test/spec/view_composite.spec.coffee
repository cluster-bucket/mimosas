((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/view_composite', '../../bin/view_component', '../../bin/view_observer'], factory
    return
  else if typeof exports is 'object'
    ViewComposite = require '../../src/view_composite.coffee'
    ViewComponent = require '../../src/view_component.coffee'
    ViewObserver = require '../../src/view_observer.coffee'
    module.exports = factory ViewComposite, ViewComponent, ViewObserver
    return
  else
    ViewComposite = root.Mimosas.ViewComposite
    ViewComponent = root.Mimosas.ViewComponent
    ViewObserver = root.Mimosas.ViewObserver
    factory ViewComposite, ViewComponent, ViewObserver
    return
) @, (ViewComposite, ViewComponent, ViewObserver) ->

  describe 'ViewComposite', ->

    composite = undefined

    beforeEach ->
      composite = new ViewComposite('#fixture')

    afterEach ->
      composite = undefined

    mockChild = (pointer) ->
      __POINTER__: pointer
      setParent: () ->

    it 'should exist', ->
      expect(ViewComposite).to.exist

    it 'should add children', ->
      expect(composite.list.count()).to.equal 0
      composite.add mockChild 'foo'
      expect(composite.list.count()).to.equal 1
      child = composite.list.get 'foo'
      expect(child.__POINTER__).to.equal 'foo'

    it 'should remove children', ->
      composite.add mockChild 'foo'
      expect(composite.list.count()).to.equal 1
      composite.remove 'foo'
      expect(composite.list.count()).to.equal 0
