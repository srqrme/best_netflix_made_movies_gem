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

  def self.scrape_profile_of_movie(movie_object)
    movie_profile_doc = Nokogiri::HTML(open(movie_object.movie_url))
    movie_profile_info = movie_profile_doc.css("#mainColumn")
      movie_object.audience_score = movie_profile_info.css(".meter-value .superPageFontColor").text
      movie_object.avg_audience_rating = movie_profile_info.css(".audience-info div[1]/text()").text.chomp.strip
  end

  def self.details(movie_object)
    if movie_object.audience_score == "" || movie_object.avg_audience_rating == ""
      puts "#{movie_object.title.upcase}"
      puts ""
      puts "Audience Score: NA"
      puts "Average Audience Rating: N/A"
    else
      puts "#{movie_object.title.upcase}"
      puts ""
      puts "Audience Score: #{movie_object.audience_score}"
      puts "Average Audience Rating: #{movie_object.avg_audience_rating}"
    end
  end
end
