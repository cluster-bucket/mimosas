define ['mimosas'], (Mimosas) ->

  class Todo extends Mimosas.ModelSubject
    constructor: (data) ->
      super
      @__POINTER__ = Mimosas.Guid.generate()
      if data.title?
        @setTitle data.title
        @setCompleted data.completed or false

    getPointer: () ->
      @__POINTER__

    getTitle: () ->
      @title

    setTitle: (@title) ->
      @notify()

    getCompleted: () ->
      @completed

    setCompleted: (@completed) ->
      @notify()

    serialize: () ->
      serialized =
        title: @title
        completed: @completed
        id: @__POINTER__
      serialized
