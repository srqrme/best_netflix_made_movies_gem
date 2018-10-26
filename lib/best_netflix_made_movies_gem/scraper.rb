require 'nokogiri'
require 'open-uri'
require 'pry'

class BestNetflixMadeMoviesGem::Scraper

  def self.scrape_movies_index
    netflix_movies_doc = Nokogiri::HTML(open("https://editorial.rottentomatoes.com/guide/best-netflix-movies-to-watch-right-now/"))
    movies = []
    netflix_movies_doc.css(".row.countdown-item").each do |row|
      title = row.css(".article_movie_title h2 a").text
      rank = row.css(".countdown-index").text
      movie_url = row.css("a.article_movie_poster").attribute("href").value
      movie_attributes = {:title => title, :rank => rank, :movie_url => movie_url}
      movies << movie_attributes
    end
    movies
  end

end
