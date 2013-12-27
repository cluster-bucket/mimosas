// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      define(factory);
    } else if (typeof exports === 'object') {
      module.exports = factory();
    } else {
      if (root.Mimosas == null) {
        root.Mimosas = {};
      }
      root.Mimosas.ControllerContext = factory();
    }
  })(this, function() {
    var ControllerContext;
    ControllerContext = (function() {
      function ControllerContext(strategy) {
        this.strategy = strategy;
      }

      ControllerContext.prototype.trigger = function(selector, type, e) {
        var method;
        if (!this.isValidEvent.apply(this, arguments)) {
          return;
        }
        method = this.makeAlgorithmInterfaceName(type);
        if (this.strategy[method] != null) {
          return this.strategy[method].call(this.strategy, e);
        }
      };

      ControllerContext.prototype.isValidEvent = function(selector, type, e) {
        var element, isChild, isType, nodes;
        element = this.view.getElement();
        nodes = element.parentNode.querySelectorAll(selector);
        isChild = nodes.length > 0;
        isType = this.strategy.events[selector] === e.type;
        return isChild && isType;
      };

      ControllerContext.prototype.makeAlgorithmInterfaceName = function(string) {
        return 'on' + string.charAt(0).toUpperCase() + string.slice(1);
      };

      ControllerContext.prototype.setView = function(view) {
        this.view = view;
        return this.bindEvents();
      };

      ControllerContext.prototype.bindEvents = function() {
        var events, selector, type;
        events = this.strategy.events || {};
        for (selector in events) {
          type = events[selector];
          this.bindEvent(selector, type);
        }
      };

      ControllerContext.prototype.bindEvent = function(selector, type) {
        var element;
        element = this.view.getElement();
        return element.addEventListener(type, this.trigger.bind(this, selector, type), false);
      };

      ControllerContext.prototype.setModel = function(model) {
        return this.strategy.setModel(model);
      };

      ControllerContext.prototype.getModel = function() {
        return this.strategy.getModel();
      };

      return ControllerContext;

    })();
    return ControllerContext;
  });

}).call(this);
