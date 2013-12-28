((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./view_observer', './controller_context', './controller_strategy'], factory
    return
  else if typeof exports is 'object'
    ViewObserver = require './view_observer'
    ControllerContex = require './controller_context'
    ControllerStrategy = require './controller_strategy'
    module.exports = factory(ViewObserver, ControllerContex, ControllerStrategy)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    ViewObserver = root.Mimosas.ViewObserver
    ControllerContex = root.Mimosas.ControllerContex
    ControllerStrategy = root.Mimosas.ControllerStrategy
    root.Mimosas.ViewComponent = factory(ViewObserver, ControllerContex, ControllerStrategy)
    return
) @, (ViewObserver, ControllerContex, ControllerStrategy) ->
  
    class ViewComponent extends ViewObserver
      constructor: (selector) ->
        super
        @setElement selector
        @controller = new ControllerContex new ControllerStrategy()
      
      setParent: (@parent) ->
 
      getParent: () -> 
        @parent
        
      setController: (controller) ->
        @controller = new ControllerContex controller
        # Init must be called before anything else
        @controller.init()
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
        
    ViewComponent