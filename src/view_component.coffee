{ViewObserver} = require './view_observer'
{ControllerContext} = require './controller_context'
{ControllerStrategy} = require './controller_strategy'

class ViewComponent extends ViewObserver
  constructor: (@element) ->
    super
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

  addEvent: (type, method, selector) ->
    handler = @dispatchEvent.bind @, method, selector
    if @element.on
      @element.on type, handler
    else if @element.addEventListener
      @element.addEventListener type, handler, false
    else if @element.addListener
      @element.addListener type, handler

  dispatchEvent: (method, selector, e) ->
    if arguments.length is 3 and selector
      return unless @elementMatchesSelector e.target, selector
    else if arguments.length is 2
      e = selector
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

exports.ViewComponent = ViewComponent
