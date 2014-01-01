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
        throw new ReferenceError 'selector' unless selector
        @element = @getElementFromSelector selector
        throw new ReferenceError '@element' unless @element
        @controller = new ControllerContext new ControllerStrategy()

      # Opt for simplicity over efficiency and compatibility
      getElementFromSelector: (selector) ->
        # After the element is set all calls will be scoped to it
        scope = @element or document
        nodes = scope.querySelectorAll selector
        return nodes[0] if nodes.length > 0
        return

      setModel: (@model) ->
        @model.attach @
        @controller.setModel @model

      getModel: () ->
        @model

      setController: (controller) ->
        @controller = new ControllerContext controller
        @controller.setView @
        @controller.setModel(@model) if @model?

      addEvent: (type, selector, method) ->
        handler = @triggerEvent.bind @, method, selector
        @element.addEventListener type, handler, false

      triggerEvent: (method, selector, e) ->
        return unless @elementMatchesSelector e.target, selector
        @controller.trigger method, e

      closest: (element, selector) ->
        return element if element is @element
        return element if @elementMatchesSelector element, selector
        parent = element.parentNode
        @closest parent, selector

      elementMatchesSelector: (element, selector) ->
        matches = false
        for prefix in ['webkit', 'moz', 'ms']
          name = "#{prefix}MatchesSelector"
          continue unless element[name]
          matches = element[name] selector
          break
        matches

      getElement: () ->
        @element

      display: () ->

    ViewComponent
