class Iterator
  constructor: (@list) ->
    @current = 0
  first: () ->
    @current = 0
    @
  next: () ->
    @current += 1
    @
  isDone: () ->
    @current >= @list.count()
  currentItem: () ->
    throw new Error "IteratorOutOfBounds" if @isDone()
    @list.getByIndex @current

exports.Iterator = Iterator
