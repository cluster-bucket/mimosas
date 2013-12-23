// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    var ViewComponent, ViewLeaf, ViewObserver;
    if (typeof define === 'function' && define.amd) {
      define(['../../bin/view_leaf', '../../bin/view_component', '../../bin/view_observer'], factory);
    } else if (typeof exports === 'object') {
      ViewLeaf = require('../../src/view_leaf.coffee');
      ViewComponent = require('../../src/view_component.coffee');
      ViewObserver = require('../../src/view_observer.coffee');
      module.exports = factory(ViewLeaf, ViewComponent, ViewObserver);
    } else {
      ViewLeaf = root.Mimosas.ViewLeaf;
      ViewComponent = root.Mimosas.ViewComponent;
      ViewObserver = root.Mimosas.ViewObserver;
      factory(ViewLeaf, ViewComponent, ViewObserver);
    }
  })(this, function(ViewLeaf, ViewComponent, ViewObserver) {
    return describe('ViewLeaf', function() {
      var leaf;
      leaf = void 0;
      beforeEach(function() {
        return leaf = new ViewLeaf('#fixture');
      });
      afterEach(function() {
        return leaf = void 0;
      });
      it('should exist', function() {
        return expect(ViewLeaf).to.exist;
      });
      it('should set a parent', function() {
        leaf.setParent('foo');
        return expect(leaf.parent).to.equal('foo');
      });
      return it('should get a parent', function() {
        leaf.setParent('bar');
        return expect(leaf.getParent()).to.equal('bar');
      });
    });
  });

}).call(this);
