((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./view_observer', './controller_context', './controller_strategy'], factory
    return
  else if typeof exports is 'object'
    ViewObserver = require './view_observer'
    ControllerContext = require './controller_context'
    ControllerStrategy = require './controller_strategy'
    module.exports = factory(ViewObserver, ControllerContext, ControllerStrategy)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    ViewObserver = root.Mimosas.ViewObserver
    ControllerContext = root.Mimosas.ControllerContext
    ControllerStrategy = root.Mimosas.ControllerStrategy
    root.Mimosas.ViewComponent = factory(ViewObserver, ControllerContext, ControllerStrategy)
    return
) @, (ViewObserver, ControllerContext, ControllerStrategy) ->

    class ViewComponent extends ViewObserver
      constructor: (selector) ->
        super
        @setElement selector
        @controller = new ControllerContext new ControllerStrategy()

      setParent: (@parent) ->

      getParent: () ->
        @parent

      setController: (controller) ->
        @controller = new ControllerContext controller
        # registerEvents must be called before anything else
        @controller.registerEvents()
        @controller.setView @
        @controller.setModel(@model) if @model?

      getController: () ->
        @controller

      setModel: (@model) ->
        @model.attach @
        @controller.setModel(@model) if @controller?

      setElement: (selector) ->
        if selector.charAt(0) is '#'
          @element = document.getElementById selector.slice 1
        else
          @element = document.querySelectorAll selector

      getElement: () ->
        @element

      selectorIsDescendant: (selector) ->
        throw new ReferenceError 'selector' unless selector?
        nodes = @element.parentNode.querySelectorAll selector
        nodes.length > 0

    ViewComponent
