class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs, :artist
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end
  
  def self.sort_by_genre_name
    Genre.all.sort {|a, b| a.name <=> b.name}
  end
    

  def artists
    songs.collect{|song| song.artist}.uniq
  end
end
