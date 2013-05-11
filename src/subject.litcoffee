
    # * Knows its obvservers. Any number of Observer objects
    #   may observe a subject
    # * Provides an interface for attaching and detaching
    #   Observer objects.
    class Subject
      constructor: () ->
        @counter = 0
        @observers = new List()
      attach: (o) ->
        o.__POINTER__ = @counter
        @observers.append o
        @counter += 1
      detach: (o) ->
        @observers.remove o
      notify: () ->
        i = new ConcreteIterator @observers
        while not i.isDone()
          i.currentItem().changed @
          i.next()