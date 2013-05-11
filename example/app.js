(function() {
  define(['collections/songs', 'views/song_list'], function(SongCollection, SongList) {
    var App, app;

    App = (function() {
      function App() {
        this.songs = new SongCollection();
        this.songs.attach(new SongList());
      }

      return App;

    })();
    app = new App();
    app.songs.addSong({
      title: 'Time After Time',
      artist: 'Cyndi Lauper',
      album: 'She\'s So Unusual'
    });
    return app.songs.addSong({
      title: 'You Belong to the City',
      artist: 'Glen Frey',
      album: 'Miami Vice Soundtrack'
    });
  });

}).call(this);
