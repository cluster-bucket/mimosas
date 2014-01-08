((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../mimosas'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.ControllerContext', ->

    it 'should exist', ->
      expect(Mimosas.ControllerContext).to.exist

    it 'should throw when a strategy is not passed into its constructor', ->
      throwMe = ->
        controllerContext = new Mimosas.ControllerContext()
      expect(throwMe).to.throw()

    it 'should set a model on the strategy', ->
      passedModel = undefined
      strategy =
        setModel: (model) ->
          passedModel = model
      controllerContext = new Mimosas.ControllerContext strategy
      controllerContext.setModel 'foo'
      expect(passedModel).to.equal 'foo'

    it 'should get a model from the strategy', ->
      strategy =
        getModel: () ->
          'foo'
      controllerContext = new Mimosas.ControllerContext strategy
      model = controllerContext.getModel()
      expect(model).to.equal 'foo'

