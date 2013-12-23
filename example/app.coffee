define [
  'cs!views/page'
  'cs!views/songs'
  'cs!views/new_song'
  'cs!collections/songs'
  'cs!controllers/new_song'
], (PageView, SongsView, NewSongView, SongCollection, NewSongController) ->

  pageView = new PageView '#page'
  songsView = new SongsView '#songs'
  newSongView = new NewSongView '#new-song'
  
  newSongView.setController new NewSongController()

  songCollection = new SongCollection()
  songsView.setModel songCollection
  newSongView.setModel songCollection

  pageView.add songsView
  pageView.add newSongView
  pageView.display()

  #songCollection.addSong
    #title: 'Time After Time'
    #artist: 'Cyndi Lauper'
    #album: 'She\'s So Unusual'

  songCollection.addSong
    title: 'You Belong to the City'
    artist: 'Glen Frey'
    album: 'Miami Vice Soundtrack'