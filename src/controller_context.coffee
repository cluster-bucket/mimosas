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
    registerEvents: () ->
      @strategy.registerEvents()

    trigger: (selector, type, method, e) ->
      return unless @isValidEvent selector, e, method
      @strategy[method].call @strategy, e

    isValidEvent: (selector, e, method) ->
      hasEvent = @eventExists selector, e, method
      hasElement = @elementExists e.target, selector
      hasMethod = @methodExists method
      hasEvent and hasElement and hasMethod

    eventExists: (selector, e, method) ->
      throw new ReferenceError 'selector' unless selector?
      throw new ReferenceError 'e' unless e?
      throw new ReferenceError 'method' unless method?
      @strategy.hasEvent e.type, selector, method

    elementExists: (element, selector) ->
      throw new ReferenceError '@view' unless @view?
      @view.elementMatchesSelector element, selector

    methodExists: (method) ->
      @strategy[method]?

    setView: (@view) ->
      @strategy.setView @view
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
