((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/guid'], factory
    return
  else if typeof exports is 'object'
    List = require '../../src/guid.coffee'
    module.exports = factory List
    return
  else
    Guid = root.Mimosas.Guid
    factory Guid
    return
) @, (Guid) ->

  describe 'Guid', ->
    
    it 'should exist', ->
      expect(Guid).to.exist

    it 'should generate a GUID', ->
      guid = Guid.generate()
      regex = /^(([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12})$/
      expect(guid).to.match regex