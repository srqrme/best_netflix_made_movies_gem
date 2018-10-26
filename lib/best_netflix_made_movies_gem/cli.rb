#CLI Controller
require 'pry'

class BestNetflixMadeMoviesGem::CLI

  def start
    puts ""
    puts "Hello and Welcome to the Best Netflix Made Movies Gem:"
    puts "A guide to the best Netflix made movies according to Rotten Tomatoes"
    puts ""
    menu
  end

  def menu
    puts ""
    puts "What would you like to do? You can:"
    puts "Enter '1' if you'd like to see Rotten Tomatoes' current list of the best movies made by Netflix, or"
    puts "Enter '2' to leave the Best Netflix Made Movies Gem"
    puts ""

    input = gets.strip.to_i

    if input == 1
      puts ""
      puts "Here are the top Netflix Original movies, listed in rank order:"
      puts ""
      list_movies
      puts ""
      run
    end
  end

  def list_movies
    BestNetflixMadeMoviesGem::Movie.create_from_scraped_movies_index
    BestNetflixMadeMoviesGem::Movie.all.each do |movie|
      puts "#{movie.rank}   #{movie.title}"
    end
  end

  def run
    puts ""
    puts "Please enter the rank number of a movie you'd like more information on:"
    puts ""

    input = gets.strip.to_i
  end
end
