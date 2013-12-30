((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./list', './iterator'], factory
    return
  else if typeof exports is 'object'
    List = require './list'
    Iterator = require './iterator'
    module.exports = factory List, Iterator
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    List = root.Mimosas.List
    Iterator = root.Mimosas.Iterator
    root.Mimosas.ControllerStrategy = factory List, Iterator
    return
) @, (List, Iterator) ->

  class ControllerStrategy
    constructor: () ->
      @events = new List()

    # Events need to be registered and the constructor is the ideal place,
    # but it's too easy to clobber the contructor by forgetting to call super.
    # registerEvents provides a safe place to call addEvent.
    registerEvents: () ->

    addEvent: (eventName, selector, method) ->
      __POINTER__ = @getPointerFromArgs.apply @, arguments
      item = {__POINTER__, selector, eventName, method}
      @events.append item

    removeEvent: (eventName, selector, method) ->
      __POINTER__ = @getPointerFromArgs.apply @, arguments
      @events.remove __POINTER__

    getEventIterator: () ->
      new Iterator @events

    hasEvent: (eventName, selector, method) ->
      __POINTER__ = @getPointerFromArgs.apply @, arguments
      item = @events.get __POINTER__
      item?

    getPointerFromArgs: () ->
      return [].slice.call(arguments, 0).join('/')

    setModel: (@model) ->
    getModel: () -> @model
    setView: (@view) ->
    getView: () -> @view

  ControllerStrategy
