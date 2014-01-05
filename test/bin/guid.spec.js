// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    var lib;
    if (typeof define === 'function' && define.amd) {
      return define(['../../mimosas'], factory);
    } else if (typeof exports === 'object') {
      lib = require('../../src/mimosas.coffee');
      return module.exports = factory(lib);
    } else {
      return factory(root.Mimosas);
    }
  })(this, function(Mimosas) {
    return describe('Mimosas.Guid', function() {
      it('should exist', function() {
        return expect(Mimosas.Guid).to.exist;
      });
      return it('should generate a GUID', function() {
        var guid, regex;
        guid = Mimosas.Guid.generate();
        regex = /^(([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12})$/;
        return expect(guid).to.match(regex);
      });
    });
  });

}).call(this);
