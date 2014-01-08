((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../mimosas'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.ViewLeaf', ->

    leaf = undefined
    eventTarget =
      addEventListener: ->

    beforeEach ->
      leaf = new Mimosas.ViewLeaf eventTarget

    afterEach ->
      leaf = undefined

    it 'should exist', ->
      expect(Mimosas.ViewLeaf).to.exist
