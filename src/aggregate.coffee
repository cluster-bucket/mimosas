((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['iterator'], factory
    return
  else if typeof exports is 'object'
    module.exports = factory(require('iterator'))
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.Aggregate = factory(root.Mimosas.Iterator)
    return
) @, (Iterator) ->

  class Aggregate
    createIterator: (items) ->
      list = new List()
      for key, val of items
        val.__POINTER__ = key
        list.append val
      new Iterator list

  Aggregate
