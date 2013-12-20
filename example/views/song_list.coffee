define ['mimosas/observer'], (Observer) ->
  
  class SongList extends Observer
    changed: (songCollection) ->
      songs = songCollection.getSongs()
      for song in songs
        console.log "#{song.getTitle()} by #{song.getArtist()}"