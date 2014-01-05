((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../src/mimosas.coffee'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.ViewLeaf', ->

    leaf = undefined
    document.body.innerHTML += '<div id="fixture"><div id="fixture-child"></div></div>'

    beforeEach ->
      leaf = new Mimosas.ViewLeaf('#fixture')

    afterEach ->
      leaf = undefined

    it 'should exist', ->
      expect(Mimosas.ViewLeaf).to.exist
