// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  (function(root, factory) {
    var ControllerContex, ViewObserver;
    if (typeof define === 'function' && define.amd) {
      define(['./view_observer', './controller_context'], factory);
    } else if (typeof exports === 'object') {
      ViewObserver = require('./view_observer');
      ControllerContex = require('./controller_context');
      module.exports = factory(ViewObserver, ControllerContex);
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      ViewObserver = root.Mimosas.ViewObserver;
      ControllerContex = root.Mimosas.ControllerContex;
      root.Mimosas.ViewComponent = factory(ViewObserver, ControllerContex);
    }
  })(this, function(ViewObserver, ControllerContex) {
    var ViewComponent;
    ViewComponent = (function(_super) {
      __extends(ViewComponent, _super);

      function ViewComponent(selector) {
        ViewComponent.__super__.constructor.apply(this, arguments);
        this.setElement(selector);
      }

      ViewComponent.prototype.setParent = function(parent) {
        this.parent = parent;
      };

      ViewComponent.prototype.getParent = function() {
        return this.parent;
      };

      ViewComponent.prototype.setController = function(controller) {
        this.controller = new ControllerContex(controller);
        return this.controller.setView(this);
      };

      ViewComponent.prototype.getController = function() {
        return this.controller;
      };

      ViewComponent.prototype.setElement = function(selector) {
        if (selector.charAt(0) === '#') {
          return this.element = document.getElementById(selector.slice(1));
        } else {
          return this.element = document.querySelectorAll(selector);
        }
      };

      ViewComponent.prototype.getElement = function() {
        return this.element;
      };

      return ViewComponent;

    })(ViewObserver);
    return ViewComponent;
  });

}).call(this);
