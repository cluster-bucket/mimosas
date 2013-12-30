((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
    return
  else if typeof exports is 'object'
    module.exports = factory()
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.ControllerContext = factory()
    return
) @, () ->

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

  ControllerContext
