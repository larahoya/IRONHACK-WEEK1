require 'pry'

class TweetList

	attr_reader :persons, :mentions, :tweets, :first_conections

	def initialize(file)
		@file = file
		@tweets = []
		@persons = []
		@mentions = {}
		@first_conections = {}
	end

	def read_file
		@tweets = IO.read(@file).split("\n").map do |tweet|
			tweet.split(":")
		end
	end

	def get_persons
		@tweets.each do |tweet|
			@persons.push(tweet[0])
		end
		@persons = @persons.uniq
  end

  def set_mentions
  	@persons.each do |person|
  		@mentions[person] = ""
  		@first_conections[person] = []
  	end
  end

  def get_mentions
  	@tweets.each do |tweet|
  		@persons.each do |person|
  			if tweet[1].include? person
  				@mentions[tweet[0]] += " #{person}"
  			end
  		end
  	end  
  end

  def get_connections
    @persons.each do |person1|
    	@persons.each do |person2|
    	  if (@mentions[person1].include? person2) && (@mentions[person2].include? person1)
    		  @first_conections[person1].push(person2)
    	    @first_conections[person2].push(person1)
    	  end
    	end
    end
    @first_conections = @first_conections.each do |key,value|
    	@first_conections[key] = value.uniq
    end
  end

end

class Person

	def initialize(name)
		@name = name
		@connections = {}
	end

end

list = TweetList.new("degrees.txt")
list.read_file
list.get_persons
list.set_mentions
list.get_mentions
list.get_connections
