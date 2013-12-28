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

    # Init is here to prevent inadvertently clobbering the constructor 
    # functionality by not using super in the extended class. 
    init: () ->
      @strategy.init()

    trigger: (selector, type, method, e) ->
      return unless @isValidEvent.apply @, arguments
      if @strategy[method]?
        @strategy[method].call(@strategy, e)
        
    isValidEvent: (selector, type, e) ->
      element = @view.getElement()
      nodes = element.parentNode.querySelectorAll selector
      isChild = nodes.length > 0
      isType = @strategy.events[selector] is e.type
      isChild and isType
        
    setView: (@view) ->
      @bindEvents()
      
    bindEvents: () ->
      events = @strategy.getEventIterator()
      while not events.isDone()
        {selector, eventName, method} = events.currentItem()
        @bindEvent selector, eventName, method
        events.next()
      
    bindEvent: (selector, type, method) ->
      element = @view.getElement()
      element.addEventListener(type, @trigger.bind(@, selector, type, method), false)
      
    setModel: (model) ->
      @strategy.setModel model
      
    getModel: () ->
      @strategy.getModel()

  ControllerContext