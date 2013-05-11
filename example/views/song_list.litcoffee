SongList (ConcreteObserver)
=============================

    define ['../../dist/mimosas'], (mimosas) ->
      
      class SongList extends mimosas.Observer
        changed: (songCollection) ->
          songs = songCollection.getSongs()
          for song in songs
            console.log "#{song.getTitle()} by #{song.getArtist()}"