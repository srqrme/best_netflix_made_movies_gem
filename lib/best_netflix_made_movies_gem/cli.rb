#CLI Controller
require 'pry'

class BestNetflixMadeMoviesGem::CLI

  def start
    puts ""
    puts "Hello and Welcome to the Best Netflix Made Movies Gem:"
    puts "A guide to the best Netflix made movies according to Rotten Tomatoes"
    puts ""
    BestNetflixMadeMoviesGem::Movie.create_from_scraped_movies_index
    menu
  end

  def menu
    puts "Would you like to see the full list of movies? Please enter Y/N:"
    puts ""

    input = gets.strip

    if input == "y" || "Y"
      puts ""
      puts "Here are the top Netflix Original movies, listed in rank order:"
      puts ""
      list_movies
      puts ""
      run
    elsif input == "n" || "N"
      quit
    else
      puts "I'm not sure I understand."
      menu
    end
  end

  def list_movies
    BestNetflixMadeMoviesGem::Movie.all.each do |movie|
      puts "#{movie.rank}   #{movie.title}"
    end
  end

  def run
    puts ""
    puts "Please enter the rank number of a movie you'd like more information on:"
    puts ""

    input = gets.strip.to_i

    if input.between?(1, 65)
      movie_object = BestNetflixMadeMoviesGem::Movie.find(input)
      BestNetflixMadeMoviesGem::Scraper.scrape_profile_of_movie(movie_object)
      BestNetflixMadeMoviesGem::Scraper.details(movie_object)
    else
      puts "I'm not sure I understand."
      menu
    end
    view_another
  end

  def view_another
    puts ""
    puts "Would you like to see the details of another movie? Enter 'Y' or 'N' "
    puts ""

    input = gets.chomp

    if input == "y" || "Y"
      run
    elsif input == "n" || "N"
      quit
    else
      puts "I'm not sure I understand."
      view_another
    end
  end

  def quit
    puts ""
    puts "Thanks for using Best Netflix Made Movies Gem, have a nice day!"
  end
end
