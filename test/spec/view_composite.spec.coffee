((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../mimosas'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.ViewComposite', ->

    composite = undefined
    eventTarget =
      addEventListener: ->

    beforeEach ->
      composite = new Mimosas.ViewComposite eventTarget

    afterEach ->
      composite = undefined

    mockChild = (pointer) ->
      __POINTER__: pointer
      setParent: () ->

    it 'should exist', ->
      expect(Mimosas.ViewComposite).to.exist

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
