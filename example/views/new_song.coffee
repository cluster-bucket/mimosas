define [
  'mimosas/view_leaf'
  'handlebars'
], (ViewLeaf, Handlebars) ->
  
  class NewSongView extends ViewLeaf

    display: (collection) ->
      @getElement().innerHTML = @toHtml()

    toHtml: (collection) ->
      template = @getTemplate()
      template()

    getTemplate: () ->
      source = document.getElementById('new-song-template').innerHTML
      Handlebars.compile source
      