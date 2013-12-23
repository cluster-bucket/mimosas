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

      ControllerContext.prototype.trigger = function(e) {
        var method;
        method = this.makeAlgorithmInterfaceName(e.type);
        if (this.strategy[method] != null) {
          return this.strategy[method].apply(this.strategy, e);
        }
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
        var element, nodes;
        element = this.view.getElement();
        nodes = element.querySelectorAll(selector);
        if (nodes.length > 0) {
          nodes[0].addEventListener(type, this.trigger.bind(this), false);
        }
      };

      return ControllerContext;

    })();
    return ControllerContext;
  });

}).call(this);