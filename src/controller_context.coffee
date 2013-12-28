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

    # Init is here to prevent inadvertently clobbering the constructor 
    # functionality by not using super in the extended class. 
    init: () ->
      @strategy.init()

    trigger: (selector, type, method, e) ->
      return unless @isValidEvent selector, method, e
      if @strategy[method]?
        @strategy[method].call(@strategy, e)

    isValidEvent: (selector, e, method) ->
      hasEvent = @eventExists selector, e, method
      hasElement = @elementExists selector
      hasEvent and hasElement
        
    eventExists: (selector, e, method) ->
      throw new ReferenceError 'selector' unless selector?
      throw new ReferenceError 'e' unless e?
      throw new ReferenceError 'method' unless method?
      @strategy.hasEvent e.type, selector, method
      
    elementExists: (selector) ->  
      throw new ReferenceError '@view' unless @view?
      throw new ReferenceError 'selector' unless selector?
      element = @view.getElement()
      return false unless element?
      nodes = element.parentNode.querySelectorAll selector
      nodes.length > 0
        
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