
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
    #movie_profile_doc = Nokogiri::HTML(open(movie_object.movie_url))
    movie_object.movie_profile_doc ||= Nokogiri::HTML(open(movie_object.movie_url))
    movie_profile_info = movie_object.movie_profile_doc.css("#mainColumn")
      movie_object.avg_critic_rating = movie_profile_info.css("#scoreStats div.superPageFontColor").first.text.gsub(/[^0-9\.\/]+[\s]/, ' ').strip
      movie_object.avg_audience_rating = movie_profile_info.css(".audience-info div[1]/text()").text.chomp.strip
      movie_object.audience_score = movie_profile_info.css(".meter-value .superPageFontColor").text
      movie_object.synopsis = movie_profile_info.css("#movieSynopsis").text.strip
      movie_object.rating = movie_profile_info.css("ul.content-meta.info li.meta-row.clearfix:first-child div.meta-value").text.strip
      movie_object.genre = movie_profile_info.css("ul li[2] .meta-value a").first.text.chomp.strip
      movie_object.director = movie_profile_info.css("ul li[3] .meta-value a").text.strip
      movie_object.cast = movie_profile_info.css(".cast-item.media.inlineBlock .media-body a span").text.strip.gsub(/[\n ]+[A Z]/, ", ")
  end
end
