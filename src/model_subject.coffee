{List} = require './list'
{Iterator} = require './iterator'
{Guid} = require './guid'

class ModelSubject
  constructor: () ->
    @__POINTER__ = Guid.generate()
    @observers = new List()

  attach: (o) ->
    unless o.__POINTER__?
      o.__POINTER__ = Guid.generate()

    @observers.append o
    return

  detach: (o) ->
    @observers.remove o
    return

  notify: ->
    i = new Iterator @observers
    while not i.isDone()
      currentItem = i.currentItem()
      if currentItem.changed?
        currentItem.changed.apply currentItem, arguments
      i.next()
    return

  # Make models into "inspectors", giving them the ability to use another
  # model as their source.
  setModel: (@model) ->
    @model.attach @

  getModel: () ->
    @model

  changed: (theChangedSubjectAspects...) ->

exports.ModelSubject = ModelSubject
