require 'imdb'
require 'pry'


movies_titles = IO.read('movie.txt').split("\n")
movies_ratings = []

movies_titles.each do |movie|
	rate = nil
	n = 0
	while rate == nil
		rate = Imdb::Search.new(movie).movies[n].rating
		n += 1
	end
	movies_ratings << rate.round
end

movies_graphic = Array.new(10){Array.new(7)}
