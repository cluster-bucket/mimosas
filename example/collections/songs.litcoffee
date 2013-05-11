SongCollection (ConcreteSubject)
================================

The SongCollection keeps a list of Views and notifies them whenever it changes 
state. In response, each View will query the SongCollection to synchronize its 
state with the SongCollection's state.

    define ['../../dist/mimosas', '../models/song'], (mimosas, Song) ->
      
      class SongCollection extends mimosas.Subject
        constructor: () ->
          @collection = []
          super
        addSong: (data) ->
          if data?
            @collection.push new Song data
            @notify()
        getSongs: () ->
          @collection
