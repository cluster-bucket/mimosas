(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['../../dist/mimosas', '../models/song'], function(mimosas, Song) {
    var SongCollection;

    return SongCollection = (function(_super) {
      __extends(SongCollection, _super);

      function SongCollection() {
        this.collection = [];
        SongCollection.__super__.constructor.apply(this, arguments);
      }

      SongCollection.prototype.addSong = function(data) {
        if (data != null) {
          this.collection.push(new Song(data));
          return this.notify();
        }
      };

      SongCollection.prototype.getSongs = function() {
        return this.collection;
      };

      return SongCollection;

    })(mimosas.Subject);
  });

}).call(this);
