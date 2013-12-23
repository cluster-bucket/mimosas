// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    var ViewComponent, ViewObserver;
    if (typeof define === 'function' && define.amd) {
      define(['../../bin/view_component', '../../bin/view_observer'], factory);
    } else if (typeof exports === 'object') {
      ViewComponent = require('../../src/view_component.coffee');
      ViewObserver = require('../../src/view_observer.coffee');
      module.exports = factory(ViewComponent, ViewObserver);
    } else {
      ViewComponent = root.Mimosas.ViewComponent;
      ViewObserver = root.Mimosas.ViewObserver;
      factory(ViewComponent, ViewObserver);
    }
  })(this, function(ViewComponent, ViewObserver) {
    return describe('ViewComponent', function() {
      var component;
      component = void 0;
      beforeEach(function() {
        return component = new ViewComponent('#fixture');
      });
      afterEach(function() {
        return component = void 0;
      });
      it('should exist', function() {
        return expect(ViewComponent).to.exist;
      });
      it('should set a parent', function() {
        component.setParent('foo');
        return expect(component.parent).to.equal('foo');
      });
      return it('should get a parent', function() {
        component.setParent('bar');
        return expect(component.getParent()).to.equal('bar');
      });
    });
  });

}).call(this);
