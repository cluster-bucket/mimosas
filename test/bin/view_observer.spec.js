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
    return describe('Mimosas.ViewObserver', function() {
      it('should exist', function() {
        return expect(Mimosas.ViewObserver).to.exist;
      });
      it('should have a changed event', function() {
        var observer;
        observer = new Mimosas.ViewObserver();
        return expect(observer.changed).to.exist;
      });
      return it('should have a pointer', function() {
        var observer;
        observer = new Mimosas.ViewObserver();
        return expect(observer.__POINTER__).to.exist;
      });
    });
  });

}).call(this);
