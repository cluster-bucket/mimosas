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
    
    # Init is here to prevent inadvertently clobbering the constructor 
    # functionality by not using super in the extended class. 
    init: () ->
      
    addEvent: (eventName, selector, method) ->
      __POINTER__ = [].slice.call(arguments, 0).join('#')
      item = {__POINTER__, selector, eventName, method}
      @events.append item
      
    removeEvent: (eventName, selector, method) ->
      __POINTER__ = [].slice.call(arguments, 0).join('#')
      @events.remove __POINTER__

    getEventIterator: () ->
      new Iterator @events
      
    setModel: (@model) ->
    getModel: () -> @model

  ControllerStrategy