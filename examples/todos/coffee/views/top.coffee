define [
  'mimosas/view_composite'
  'mimosas/iterator'
], (ViewComposite, Iterator) ->

  class TopView extends ViewComposite

    display: () ->
      i = new Iterator @list
      while not i.isDone()
        i.currentItem().display()
        i.next()
