require 'imdb'
require 'pry'



class FilmList

	attr_reader :films, :ratings

  def initialize
    @films = []
    @ratings = []
  end

  def read_file(file)
    @films = IO.read(file).split("\n")
  end

  def load_rating
  	@films.each do |movie|
  		rating = Imdb::Search.new(movie).movies[0].rating
  		if rating == nil
  			rating = Imdb::Search.new(movie).movies[1].rating
  		end
  	  @ratings.push(rating.round)
  	end
  end

end

class RatingGraphic

	attr_reader :graphic

  def initialize(film_list)
    @film_list = film_list
    @graphic = []
  end

  def generate_array
    @graphic = Array.new(10){Array.new(@film_list.films.size){" "}}
  end

  def put_ratings
    @film_list.ratings.each_with_index do |rating,index|
      n = rating
      while n >= 0
        @graphic[n][index] = "#"
        n-=1
      end
    end
    @graphic = @graphic.reverse
  end

  def print_rating
    @graphic.each do |line|
    	line.each_with_index do |i, index|
    		if index != (line.size - 1)
    			print "| #{i} "
    		else
    			puts "| #{i} |"
    		end
    	end
    end
    puts "| 1 | 2 | 3 | 4 | 5 | 6 | 7 | \n"
  end

  def print_films
    @film_list.films.each_with_index do |film,index|
  	  puts "#{index+1}: #{film}"
    end
  end

  def print_graphic
    generate_array
    put_ratings

    print_rating
    print_films
  end

end

my_list = FilmList.new
my_list.read_file("movie.txt")
my_list.load_rating

my_graphic = RatingGraphic.new(my_list)
my_graphic.print_graphic

