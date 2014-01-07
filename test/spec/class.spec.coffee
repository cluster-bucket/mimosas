((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../src/mimosas.coffee'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.Class', ->

    it 'should exist', ->
      expect(Mimosas.Class).to.exist

    it 'should extend a constructor function', ->
      class Bar
        type: -> 'bar'
        baz: -> true

      `var Foo = (function (_super) {
        Mimosas.Class.extends(Foo, _super);
        function Foo() {}
        Foo.prototype.type = function () { return 'foo'; }
        return Foo;
      })(Bar)`

      foo = new Foo()
      expect(foo.baz).to.exist

