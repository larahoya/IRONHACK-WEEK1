require 'pry'

class Player
	
	attr_reader :name, :objects

	def initialize(name)
		@name = name
		@objects = []
	end

end

class Room

	attr_reader :number, :other_rooms, :initial_description, :object

	def initialize(number,other_rooms, initial_description, object = nil)
		@number = number
		@other_rooms = other_rooms
		@initial_description = initial_description
		@object = object
	end
end

class Game
	def initialize(player,rooms)
		@player = player
		@rooms = rooms
		@current_room = @rooms[0].number
		@direction = nil
	end

	def play
	  puts_description
	  check_objects
	  puts_direction
	  get_user_input
      change_room
	end

	def puts_direction
		directions = "\nExists: "
		directions << "N " if @rooms[@current_room].other_rooms[0] != nil
		directions << "E " if @rooms[@current_room].other_rooms[1] != nil
		directions << "S " if @rooms[@current_room].other_rooms[2] != nil
		directions << "W " if @rooms[@current_room].other_rooms[3] != nil
		puts directions
	end

	def puts_description
	  puts "\n#{@rooms[@current_room].initial_description}"
	end

	def check_objects
		if @rooms[@current_room].object != nil
			puts "You can take a #{@rooms[@current_room].object}"
			take_objects
		end
	end

	def take_objects
	  puts "Do you take it? Y/N"
	  user_input = gets.chomp.upcase
	  if user_input == "Y"
	  	@player.objects << @rooms[@current_room].object
	  	puts "You have take a #{@rooms[@current_room].object}"
	  else
	  	puts "You have decided not to take it!"
	  end		
	end

	def get_user_input
	  puts "Select your next move"
	  user_input = gets.chomp.upcase
  	  case user_input
		when 'N'
			@direction = 0
		when 'E'
			@direction = 1
		when 'S'
			@direction = 2
		when 'W'
			@direction = 3
		when 'EXIT'
			@direction = nil
		else
			puts "Incorrect move!"
	  end
	end 

	def change_room
	  if @direction == nil
	  	puts "GOOD BYE!"
	  elsif @rooms[@current_room].other_rooms[@direction] == nil
	    puts "You can't do this move!"
		play
	  elsif
		@rooms[@current_room].other_rooms[@direction] == false
		puts "YOU WIN!"
	  else
		@current_room = @rooms[@current_room].other_rooms[@direction]
		play
	  end
	end

end

room_0 = Room.new(0, [1, nil, nil, nil], "You are in the room 0")
room_1 = Room.new(1, [nil, 2, 0, nil], "You are in the room 1")
room_2 = Room.new(2, [3, nil, nil, 1], "You are in the room 2", "sword")
room_3 = Room.new(3, [nil, 4, 2, nil], "You are in the room 3", "gun")
room_4 = Room.new(4, [nil, false, nil, 3], "You are in the room 4")

player_1 = Player.new("Lara")

my_game = Game.new(player_1, [room_0, room_1, room_2, room_3, room_4])

my_game.play
