
    # Implements the Iterator creation interface to return an
    # instance of the proper ConcreteIterator
    class ConcreteAggregate extends Aggregate
      createIterator: (items) ->
        list = new List()
        for key, val of items
          val.__POINTER__ = key
          list.append val
        new ConcreteIterator list