class Aggregate
  createIterator: (items) ->
    list = new List()
    for key, val of items
      val.__POINTER__ = key
      list.append val
    new Iterator list
