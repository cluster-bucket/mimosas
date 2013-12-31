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

