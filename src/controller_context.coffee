class ControllerContext

  constructor: (@strategy) ->
    throw new Error 'ArgumentException' unless @strategy?

  trigger: (method, e) ->
    if @strategy[method]?
      @strategy[method].call @strategy, e

  setModel: (model) ->
    @strategy.setModel model

  getModel: () ->
    @strategy.getModel()

  setView: (@view) ->
    @strategy.setView @view

exports.ControllerContext = ControllerContext
