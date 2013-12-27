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

    trigger: (selector, type, e) ->
      return unless @isValidEvent.apply @, arguments
      method = @makeAlgorithmInterfaceName type
      if @strategy[method]?
        @strategy[method].call(@strategy, e)
        
    isValidEvent: (selector, type, e) ->
      element = @view.getElement()
      nodes = element.parentNode.querySelectorAll selector
      isChild = nodes.length > 0
      isType = @strategy.events[selector] is e.type
      isChild and isType
        
    # http://stackoverflow.com/a/1026087
    makeAlgorithmInterfaceName: (string) ->
      'on' + string.charAt(0).toUpperCase() + string.slice(1)
    
    setView: (@view) ->
      @bindEvents()
      
    bindEvents: () ->
      events  = @strategy.events or {}
      for selector, type of events
        @bindEvent selector, type
      return
      
    bindEvent: (selector, type) ->
      element = @view.getElement()
      element.addEventListener(type, @trigger.bind(@, selector, type), false)
      
    setModel: (model) ->
      @strategy.setModel model
      
    getModel: () ->
      @strategy.getModel()
      
  ControllerContext