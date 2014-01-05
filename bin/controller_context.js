// Generated by CoffeeScript 1.6.3
var ControllerContext;

ControllerContext = (function() {
  function ControllerContext(strategy) {
    this.strategy = strategy;
    if (this.strategy == null) {
      throw new Error('ArgumentException');
    }
  }

  ControllerContext.prototype.trigger = function(method, e) {
    if (this.strategy[method] != null) {
      return this.strategy[method].call(this.strategy, e);
    }
  };

  ControllerContext.prototype.setModel = function(model) {
    return this.strategy.setModel(model);
  };

  ControllerContext.prototype.getModel = function() {
    return this.strategy.getModel();
  };

  ControllerContext.prototype.setView = function(view) {
    this.view = view;
    return this.strategy.setView(this.view);
  };

  return ControllerContext;

})();

exports.ControllerContext = ControllerContext;
