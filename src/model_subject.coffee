{List} = require './list'
{Iterator} = require './iterator'

class ModelSubject
  constructor: () ->
    @observers = new List()

  attach: (obj) ->
    @observers.append obj

  detach: (observer) ->
    @observers.remove observer

  # Broadcast the aspect that was changed
  notify: (aspect) ->
    i = new Iterator @observers
    until i.isDone()
      currentItem  = i.currentItem()
      currentItem.changed.call currentItem, aspect
      i.next()

exports.ModelSubject = ModelSubject
