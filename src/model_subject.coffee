{List} = require './list'
{Iterator} = require './iterator'

class exports.ModelSubject
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

