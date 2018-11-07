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

    input = gets.strip.downcase

    if input == "y"
      puts ""
      puts "Here are the top Netflix Original movies, listed in rank order:"
      puts ""
      list_movies
      puts ""
      run
    elsif input == "n"
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
      binding.pry
      details(movie_object)
    else
      puts "I'm not sure I understand"
    end
    view_another
  end

  def view_another
    puts ""
    puts "Would you like to see the details of another movie? Enter 'Y' or 'N' "
    puts ""

    input = gets.chomp.downcase

    if input == "y"
      run
    elsif input == "n"
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

  def details(movie_object)
    if movie_object.rating == "" || movie_object.genre == "" || movie_object.director == "" || movie_object.cast == ""
      puts "#{movie_object.title.upcase}"
      puts "..............................................."
      puts ""
      puts "#{movie_object.synopsis}"
      puts "- Critics gave it a #{movie_object.avg_critic_rating}"
      puts "- Audiences gave it a #{movie_object.avg_audience_rating}"
    else
      puts "#{movie_object.title.upcase}"
      puts "..............................................."
      puts "#{movie_object.synopsis}"
      puts "- This movie is rated  #{movie_object.rating}"
      puts "- Genre:  #{movie_object.genre}"
      puts "- Director:   #{movie_object.director}"
      puts "- Starring:   #{movie_object.cast}"
      puts "- Critics gave it a #{movie_object.avg_critic_rating}"
      puts "- Audiences gave it a #{movie_object.avg_audience_rating}"
    end
  end
end
