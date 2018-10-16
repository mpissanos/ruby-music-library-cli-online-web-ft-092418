class MusicLibraryController

  attr_accessor :path
  extend Concerns::Findable

  def initialize(filepath= "./db/mp3s")
   self.path = filepath
   MusicImporter.new(self.path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

    end
  end
  
  
  def print_song(song, i)
     puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end
   
  def print_artist (artist, i)
     puts "#{i}. #{artist.name}"
  end
   
  def print_genre(genre, i)
     puts "#{i}. #{genre.name}"
  end
   
  def list_songs
      ordered_list =  Song.sort_by_song_name
      ordered_list.each.with_index(1) { |song, i| print_song(song, i)}
  end
    
   
  def list_artists
      sorted_list =  Artist.sort_by_artist_name
      sorted_list.each.with_index(1) {|artist, i| print_artist(artist, i)}
  end
   
  def list_genres
      sorted_list =  Genre.sort_by_genre_name
      sorted_list.each.with_index(1) { |genre, i| print_genre(genre, i) }
  end
   
   
  def list_artist
    puts "Enter artist"
    specific_artist = gets.chomp
    if Artist.find_by_name(specific_artist) != nil
      Artist.find_by_name(specific_artist).songs.each.with_index {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
    else
      puts "Artist does not exist"
    end
  end
   
  def list_genre
    puts "Enter genre"
    specific_genre = gets.chomp
      if Genre.find_by_name(specific_genre) != nil
        Genre.find_by_name(specific_genre).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
      else
        puts "Genre does not exist"
      end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    specific_artist = gets.chomp
      if Artist.find_by_name(specific_artist) != nil
        song_list = Artist.find_by_name(specific_artist).songs.sort_by {|song| song.name}
        song_list.each.with_index(1) {|song, i| puts "#{i}. #{song.name} - #{song.genre.name}"}
      end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    specific_genre = gets.chomp
      if Genre.find_by_name(specific_genre) != nil
        song_list = Genre.find_by_name(specific_genre).songs.sort_by {|song| song.name}
        song_list.each.with_index(1) {|song, i| puts "#{i}. #{song.artist.name} - #{song.name}"}
      end
    end
    

  def play_song
    puts "Which song number would you like to play?"
    choice = gets.strip.to_i
      if choice.between?(1, Song.all.length)
        song = Song.sort_by_song_name[choice - 1]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
  end


  
end