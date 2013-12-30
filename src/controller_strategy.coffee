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
    setModel: (@model) ->
    getModel: () -> @model
    setView: (@view) ->
    getView: () -> @view

  ControllerStrategy
