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
    
    trigger: (e) ->
      method = @makeAlgorithmInterfaceName e.type
      if @strategy[method]?
        @strategy[method].apply(@strategy, e)
        
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
      nodes = element.querySelectorAll selector
      if nodes.length > 0
        nodes[0].addEventListener(type, @trigger.bind(@), false)
      return
      
  ControllerContext