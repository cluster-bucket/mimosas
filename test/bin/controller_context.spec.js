// Generated by CoffeeScript 1.6.3
(function() {
  (function(root, factory) {
    var ControllerContext;
    if (typeof define === 'function' && define.amd) {
      define(['../../bin/controller_context'], factory);
    } else if (typeof exports === 'object') {
      ControllerContext = require('../../src/controller_context.coffee');
      module.exports = factory(ControllerContext);
    } else {
      ControllerContext = root.Mimosas.ControllerContext;
      factory(ControllerContext);
    }
  })(this, function(ControllerContext) {
    return describe('ControllerContext', function() {
      /*   
      controllerContext = undefined
      
      mockStrategy: () ->
        strategy =
          init: () ->
      
      beforeEach ->
        strategy = mockStrategy()
        controllerContext = new ControllerContext strategy
      
      afterEach ->
        controllerContext = undefined
      */

      it('should exist', function() {
        return expect(ControllerContext).to.exist;
      });
      it('should throw when a strategy is not passed into its constructor', function() {
        var throwMe;
        throwMe = function() {
          var controllerContext;
          return controllerContext = new ControllerContext();
        };
        return expect(throwMe).to["throw"]();
      });
      it('should call init on the strategy', function() {
        var controllerContext, initCalled, strategy;
        initCalled = false;
        strategy = {
          init: function() {
            return initCalled = true;
          }
        };
        controllerContext = new ControllerContext(strategy);
        controllerContext.init();
        return expect(initCalled).to.be["true"];
      });
      it('should set a model on the strategy', function() {
        var controllerContext, passedModel, strategy;
        passedModel = void 0;
        strategy = {
          setModel: function(model) {
            return passedModel = model;
          }
        };
        controllerContext = new ControllerContext(strategy);
        controllerContext.setModel('foo');
        return expect(passedModel).to.equal('foo');
      });
      it('should get a model from the strategy', function() {
        var controllerContext, model, strategy;
        strategy = {
          getModel: function() {
            return 'foo';
          }
        };
        controllerContext = new ControllerContext(strategy);
        model = controllerContext.getModel();
        return expect(model).to.equal('foo');
      });
      it('should throw a ReferenceError if isValidEvent is called without a view', function() {
        var controllerContext, strategy, throwMe;
        strategy = {
          hasEvent: function() {
            return false;
          }
        };
        controllerContext = new ControllerContext(strategy);
        throwMe = function() {
          return controllerContext.isValidEvent('#fixture', 'onClick', {});
        };
        return expect(throwMe).to["throw"](ReferenceError);
      });
      it('should throw a ReferenceError if isValidEvent is called without a selector', function() {
        var controllerContext, throwMe;
        controllerContext = new ControllerContext({});
        throwMe = function() {
          return controllerContext.isValidEvent(null, 'onClick', {});
        };
        return expect(throwMe).to["throw"](ReferenceError);
      });
      it('should throw a ReferenceError if isValidEvent is called without a method', function() {
        var controllerContext, throwMe;
        controllerContext = new ControllerContext({});
        throwMe = function() {
          return controllerContext.isValidEvent('#fixture', null, {});
        };
        return expect(throwMe).to["throw"](ReferenceError);
      });
      it('should throw a ReferenceError if isValidEvent is called without an event', function() {
        var controllerContext, throwMe;
        controllerContext = new ControllerContext({});
        throwMe = function() {
          return controllerContext.isValidEvent('#fixture', 'onClick', null);
        };
        return expect(throwMe).to["throw"](ReferenceError);
      });
      it('should return true if the event and element exist', function() {
        var controllerContext, result, strategy, view;
        strategy = {
          hasEvent: function() {
            return true;
          }
        };
        view = {
          getElement: function() {
            return document.getElementById('fixture');
          }
        };
        controllerContext = new ControllerContext(strategy);
        controllerContext.view = view;
        result = controllerContext.isValidEvent('#fixture', {
          type: 'click'
        }, 'onClick');
        return expect(result).to.be["true"];
      });
      it('should return false if the event doesn\'t exist and the element does', function() {
        var controllerContext, result, strategy, view;
        strategy = {
          hasEvent: function() {
            return false;
          }
        };
        view = {
          getElement: function() {
            return document.getElementById('fixture');
          }
        };
        controllerContext = new ControllerContext(strategy);
        controllerContext.view = view;
        result = controllerContext.isValidEvent('#fixture', {
          type: 'click'
        }, 'onClick');
        return expect(result).to.be["false"];
      });
      return it('should return false if the event exists and the element doesn\'t', function() {
        var controllerContext, result, strategy, view;
        strategy = {
          hasEvent: function() {
            return true;
          }
        };
        view = {
          getElement: function() {
            return document.getElementById('xfixture');
          }
        };
        controllerContext = new ControllerContext(strategy);
        controllerContext.view = view;
        result = controllerContext.isValidEvent('#xfixture', {
          type: 'click'
        }, 'onClick');
        return expect(result).to.be["false"];
      });
    });
  });

}).call(this);
