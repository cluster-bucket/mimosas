define [
  'mimosas/view_composite'
  'mimosas/iterator'
  'handlebars'
], (ViewComposite, Iterator, Handlebars) ->
  
  class Page extends ViewComposite
    constructor: () ->
      super
      @iterator = new Iterator @list

    display: () ->
      @iterator.first()
      while not @iterator.isDone()
        @iterator.currentItem().display()
        @iterator.next()