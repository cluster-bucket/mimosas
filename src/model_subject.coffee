((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./list', './iterator'], factory
    return
  else if typeof exports is 'object'
    List = require('./list')
    Iterator = require('./iterator')
    module.exports = factory(List, Iterator)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    List = root.Mimosas.List
    Iterator = root.Mimosas.Iterator
    root.Mimosas.ModelSubject = factory(List, Iterator)
    return
) @, (List, Iterator) ->

  class ModelSubject

    constructor: () ->
      @observers = new List()

    attach: (obj) ->
      @observers.append obj

    detach: (observer) ->
      @observers.remove observer

    notify: () ->
      i = new Iterator @observers
      while not i.isDone()
        i.currentItem().changed @
        i.next()

  ModelSubject
