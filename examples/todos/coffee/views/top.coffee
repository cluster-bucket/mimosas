define ['mimosas', 'handlebars'], (Mimosas, Handlebars) ->

  class TopView extends Mimosas.ViewComposite

    display: () ->
      i = new Mimosas.Iterator @list
      while not i.isDone()
        i.currentItem().display()
        i.next()
