((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/controller_context'], factory
    return
  else if typeof exports is 'object'
    ControllerContext = require '../../src/controller_context.coffee'
    module.exports = factory ControllerContext
    return
  else
    ControllerContext = root.Mimosas.ControllerContext
    factory ControllerContext
    return
) @, (ControllerContext) ->

  describe 'ControllerContext', ->

    it 'should exist', ->
      expect(ControllerContext).to.exist

    it 'should throw when a strategy is not passed into its constructor', ->
      throwMe = ->
        controllerContext = new ControllerContext()
      expect(throwMe).to.throw()

    it 'should call registerEvents on the strategy', ->
      registerEventsCalled = false
      strategy =
        registerEvents: () ->
          registerEventsCalled = true
      controllerContext = new ControllerContext strategy
      controllerContext.registerEvents()
      expect(registerEventsCalled).to.be.true

    it 'should set a model on the strategy', ->
      passedModel = undefined
      strategy =
        setModel: (model) ->
          passedModel = model
      controllerContext = new ControllerContext strategy
      controllerContext.setModel 'foo'
      expect(passedModel).to.equal 'foo'

    it 'should get a model from the strategy', ->
      strategy =
        getModel: () ->
          'foo'
      controllerContext = new ControllerContext strategy
      model = controllerContext.getModel()
      expect(model).to.equal 'foo'

    it 'should throw a ReferenceError if isValidEvent is called without a view', ->
      strategy =
        hasEvent: () ->
          false
      controllerContext = new ControllerContext strategy
      throwMe = ->
        controllerContext.isValidEvent '#fixture', 'onClick', {}
      expect(throwMe).to.throw(ReferenceError)

    it 'should throw a ReferenceError if isValidEvent is called without a selector', ->
      controllerContext = new ControllerContext {}
      throwMe = ->
        controllerContext.isValidEvent null, 'onClick', {}
      expect(throwMe).to.throw(ReferenceError)

    it 'should throw a ReferenceError if isValidEvent is called without a method', ->
      controllerContext = new ControllerContext {}
      throwMe = ->
        controllerContext.isValidEvent '#fixture', null, {}
      expect(throwMe).to.throw(ReferenceError)

    it 'should throw a ReferenceError if isValidEvent is called without an event', ->
      controllerContext = new ControllerContext {}
      throwMe = ->
        controllerContext.isValidEvent '#fixture', 'onClick', null
      expect(throwMe).to.throw(ReferenceError)

    it 'should return true if the event and element exist', ->
      strategy =
        hasEvent: () ->
          true
      view =
        getElement: () ->
          document.getElementById 'fixture'

      controllerContext = new ControllerContext strategy
      controllerContext.view = view
      result = controllerContext.isValidEvent '#fixture', {type: 'click'}, 'onClick'
      expect(result).to.be.true

    it 'should return false if the event doesn\'t exist and the element does', ->
      strategy =
        hasEvent: () ->
          false
      view =
        getElement: () ->
          document.getElementById 'fixture'

      controllerContext = new ControllerContext strategy
      controllerContext.view = view
      result = controllerContext.isValidEvent '#fixture', {type: 'click'}, 'onClick'
      expect(result).to.be.false

    it 'should return false if the event exists and the element doesn\'t', ->
      strategy =
        hasEvent: () ->
          true
      view =
        getElement: () ->
          document.getElementById 'xfixture'

      controllerContext = new ControllerContext strategy
      controllerContext.view = view
      result = controllerContext.isValidEvent '#xfixture', {type: 'click'}, 'onClick'
      expect(result).to.be.false
