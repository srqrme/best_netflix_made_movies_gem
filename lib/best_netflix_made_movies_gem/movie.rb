require 'pry'

class BestNetflixMadeMoviesGem::Movie

  attr_accessor :title, :rank, :movie_url

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
      self.send(("#{key}="), value)
    end
    @@all << self
  end

end
