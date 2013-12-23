define [
  'cs!views/page'
  'cs!views/songs'
  'cs!views/new_song'
  'cs!collections/songs'
  'cs!controllers/new_song'
], (PageView, SongsView, NewSongView, SongCollection, NewSongController) ->

  class App
    @run = () ->
      page = new PageView '#page'
      songsView = new SongsView '#songs'
      newSongView = new NewSongView '#new-song'
      
      newSongView.setController new NewSongController()
    
      songCollection = new SongCollection()
      songsView.setModel songCollection
      newSongView.setModel songCollection

      page.add songsView
      page.add newSongView
      page.display()

      songCollection.addSong
        title: 'Time After Time'
        artist: 'Cyndi Lauper'
        album: 'She\'s So Unusual'
    
      songCollection.addSong
        title: 'You Belong to the City'
        artist: 'Glen Frey'
        album: 'Miami Vice Soundtrack'

  # window.document.addEventListener 'DOMContentLoaded', () ->
  App.run()
