define [
  'mimosas/composite'
  'mimosas/iterator'
  'handlebars'
], (Composite, Iterator, Handlebars) ->
  
  class Page extends Composite
    constructor: () ->
      super
      @iterator = new Iterator @list

    display: () ->
      @iterator.first()
      while not @iterator.isDone()
        @iterator.currentItem().display()
        @iterator.next()