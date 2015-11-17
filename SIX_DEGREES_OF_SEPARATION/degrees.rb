require 'pry'

class TweetList

	attr_reader :persons, :mentions, :tweets, :first, :second, :third, :connections

	def initialize(file)
		@file = file
		@tweets = []
		@persons = []
		@mentions = {}
    @first = {}
    @second = {}
    @third = {}
    @connections = []
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

  def get_mentions
  	@tweets.each do |tweet|
  		@persons.each do |person|
  			if tweet[1].include? person
  				@mentions[tweet[0]] ? @mentions[tweet[0]] << "#{person}" : @mentions[tweet[0]] = ["#{person}"]
  			end
  		end
  	end  
  end

  def hash_uniq_value(hash)
    hash.each do |key, value|
      hash[key] = value.uniq
    end
  end

  def search(hash1, hash2)
    @persons.each do |person1|
      hash1[person1].each do |person2|
        hash1[person2].each do |person|
          if (person != person1) && (hash1[person1].include?(person) == false)
            hash2[person1] ? hash2[person1] << "#{person}" : hash2[person1] = ["#{person}"]
          end
        end
      end
    end
  end

  def get_first
    @persons.each do |person1|
      @persons.each do |person2|
        if (@mentions[person1].include? person2) && (@mentions[person2].include? person1)
          @first[person1] ? @first[person1] << "#{person2}" : @first[person1] = ["#{person2}"]
          @first[person2] ? @first[person2] << "#{person1}" : @first[person2] = ["#{person1}"]
        end
      end
    end
    @first = hash_uniq_value(@first)
  end

  def get_second
    search(@first, @second)
    @second = hash_uniq_value(@second)
  end

  def get_third
    search(@second, @third)
    @third = hash_uniq_value(@third)
    @third.each do |key, value|
      @third[key].delete_if {|name| @first[key].include?(name)}
    end
  end

  def get_connections
    @persons.each do |person|
      hash = {name: person, first: @first[person], second: @second[person], third: @third[person]}
      @connections.push(hash)
    end
  end


end


list = TweetList.new("degrees.txt")
list.read_file
list.get_persons
list.get_mentions
list.get_first
list.get_second
list.get_third
list.get_connections


binding.pry
