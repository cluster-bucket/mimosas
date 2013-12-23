define [
  'mimosas/leaf'
  'handlebars'
], (Leaf, Handlebars) ->
  
  class SongsView extends Leaf

    changed: (collection) ->
      @display collection

    display: (collection) ->
      return unless collection?
      html = @toHtml collection.serialize()
      @getElement().innerHTML = html

    toHtml: (collection) ->
      template = @getTemplate()
      template songs: collection

    getTemplate: () ->
      source = document.getElementById('songs-template').innerHTML
      Handlebars.compile source
