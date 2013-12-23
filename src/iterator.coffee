((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
    return
  else if typeof exports is 'object'
    module.exports = factory()
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.Iterator = factory()
    return
) @, () ->
  
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
      
  Iterator