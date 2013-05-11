
    # * Implements the Iterator interface
    # * Keeps track of the current position in the traversal
    #   of the aggregate
    class ConcreteIterator extends Iterator
      constructor: (@list) ->
        @current = 0
      first: () ->
        @current = 0
      next: () ->
        @current += 1
      isDone: () ->
        @current >= @list.count()
      currentItem: () ->
        throw new Error "IteratorOutOfBounds" if @isDone()
        @list.get @current