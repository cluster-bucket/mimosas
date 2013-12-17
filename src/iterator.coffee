((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
  else if typeof exports is 'object'
    module.exports = factory()
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.Iterator = factory()
) @, () ->
  
  class Iterator
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
      @list.getByIndex @current
      