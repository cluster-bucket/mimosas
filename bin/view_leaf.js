// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  (function(root, factory) {
    var ViewComponent;
    if (typeof define === 'function' && define.amd) {
      define(['./view_component'], factory);
    } else if (typeof exports === 'object') {
      ViewComponent = require('./view_component');
      module.exports = factory(ViewComponent);
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      ViewComponent = root.Mimosas.ViewComponent;
      root.Mimosas.ViewLeaf = factory(ViewComponent);
    }
  })(this, function(ViewComponent) {
    var ViewLeaf, _ref;
    ViewLeaf = (function(_super) {
      __extends(ViewLeaf, _super);

      function ViewLeaf() {
        _ref = ViewLeaf.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      return ViewLeaf;

    })(ViewComponent);
    return ViewLeaf;
  });

}).call(this);