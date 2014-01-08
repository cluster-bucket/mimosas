((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../mimosas'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.Guid', ->

    it 'should exist', ->
      expect(Mimosas.Guid).to.exist

    it 'should generate a GUID', ->
      guid = Mimosas.Guid.generate()
      regex = /^(([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12})$/
      expect(guid).to.match regex
