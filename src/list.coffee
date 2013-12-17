((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
  else if typeof exports is 'object'
    module.exports = factory()
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.List = factory()
) @, () ->

  class List
    constructor: () ->
      pointers = []
      items = {}

      @count = () ->
        pointers.length

      @get = (pointer) ->
        items[pointer]

      @getByIndex = (index) ->
        throw new Error 'ArrayOutOfBoundsException' if index >= @count()
        throw new Error 'ArrayOutOfBoundsException' if index < 0
        items[pointers[index]]

      @first = () ->
        items[pointers[0]]

      @last = () ->
        items[pointers[pointers.length - 1]]

      @append = (item) ->
        throw new Error 'NullPointerException' unless item.__POINTER__?
        pointer = item.__POINTER__
        pointers.push pointer
        items[pointer] = item

      @remove = (pointer) ->
        throw new Error 'ArgumentException' unless pointer?
        throw new Error 'ListItemUndefined' unless items[pointer]?

        index = -1
        for item, i in pointers
          if item is pointer
            index = i
            break

        throw new Error 'ListItemUndefined' if index is -1

        delete items[pointer]
        pointers.splice index, 1

      @removeLast = () ->
        item = @last()
        @remove item.__POINTER__

      @removeFirst = () ->
        item = @first()
        @remove item.__POINTER__

      @removeAll = () ->
        pointers = []
        items = {}
