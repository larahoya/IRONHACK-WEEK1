require 'pry'

class TweetList

	attr_reader :persons, :mentions, :tweets, :first_conections

	def initialize(file)
		@file = file
		@tweets = []
		@persons = []
		@mentions = {}
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

end

class ConnectionList

  attr_reader :first, :second

  def initialize(persons, mentions)
    @persons = persons
    @mentions = mentions
    @first = {}
    @second = {}
  end

  def set_hashes
    @persons.each do |person|
      @first[person] = []
      @second[person] = []
    end
  end

  def get_first
    @persons.each do |person1|
      @persons.each do |person2|
        if (@mentions[person1].include? person2) && (@mentions[person2].include? person1)
          @first[person1].push(person2)
          @first[person2].push(person1)
        end
      end
    end
    @first = @first.each do |key,value|
      @first[key] = value.uniq
    end
  end

  def get_second
    @persons.each do |person1|
      @persons.each do |person2|
        @persons.each do |person3|
          if (@first[person1].include? person3) && (@first[person2].include? person3)
            @second[person1].push(person3)
            @second[person2].push(person3)
          end
        end
      end
    end
    @second = @second.each do |key,value|
      @second[key] = value.uniq
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

connectionlist = ConnectionList.new(list.persons, list.mentions)
connectionlist.set_hashes
connectionlist.get_first
connectionlist.get_second

binding.pry
