require 'pry'

class BestNetflixMadeMoviesGem::Movie

  attr_accessor :title, :rank, :movie_url, :audience_score, :avg_audience_rating, :avg_critic_rating, :synopsis, :rating, :genre, :director, :cast, :movie_profile_doc

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
      self.send(("#{key}="), value)
    end
    @@all << self
  end

  def self.create_from_scraped_movies_index
    BestNetflixMadeMoviesGem::Scraper.scrape_movies_index.each do |movie|
      self.new(movie)
    end
  end

  def self.all
    @@all
  end

  def self.find(m)
    self.all[m-1]
  end

  def avg_critic_rating
    @avg_critic_rating ||= doc.css("#scoreStats div.superPageFontColor").first.text.gsub(/[^0-9\.\/]+[\s]/, ' ').strip
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.movie_url))
  end
end
