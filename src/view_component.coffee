((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./view_observer', './controller_context'], factory
    return
  else if typeof exports is 'object'
    ViewObserver = require './view_observer'
    ControllerContex = require './controller_context'
    module.exports = factory(ViewObserver, ControllerContex)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    ViewObserver = root.Mimosas.ViewObserver
    ControllerContex = root.Mimosas.ControllerContex
    root.Mimosas.ViewComponent = factory(ViewObserver, ControllerContex)
    return
) @, (ViewObserver, ControllerContex) ->
  
    class ViewComponent extends ViewObserver
      constructor: (selector) ->
        super
        @setElement selector
      
      setParent: (@parent) ->
 
      getParent: () -> 
        @parent
        
      setController: (controller) ->
        @controller = new ControllerContex controller
        @controller.setView @
        
      getController: () ->
        @controller
        
      setModel: (@model) ->
        @model.attach @
        
      setElement: (selector) ->
        if selector.charAt(0) is '#'
          @element = document.getElementById selector.slice 1
        else
          @element = document.querySelectorAll selector
        
      getElement: () -> 
        @element
        
    ViewComponent