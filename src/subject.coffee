((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./list', './iterator'], factory
  else if typeof exports is 'object'
    List = require('./list')
    Iterator = require('./iterator')
    module.exports = factory(List, Iterator)
  else
    root.Mimosas = {} unless root.Mimosas?
    List = root.Mimosas.List
    Iterator = root.Mimosas.Iterator
    root.Mimosas.Subject = factory(List, Iterator)
) @, (List, Iterator) ->

  class Subject
  
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
