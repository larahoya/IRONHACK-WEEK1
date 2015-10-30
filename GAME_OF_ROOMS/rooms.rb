

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

	attr_reader :rooms, :current_room, :direction
	
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
	  system "clear"
	  puts "#{@rooms[@current_room].initial_description}"
	end

	def check_objects
		if @rooms[@current_room].object != nil
			puts "\nYou find a #{@rooms[@current_room].object}"
			take_objects
		end
	end

	def take_objects
	  puts "Do you take it with you? Y/N"
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

class GameSaver 

	def initialize(player, rooms, current_room, direction)
		super(player, rooms)
		@current_room = current_room
		@direction = direction
	end

end

room_0 = Room.new(0, [1, nil, 5, nil], "You are in the room 0")
room_1 = Room.new(1, [nil, 2, 0, nil], "You are in the room 1")
room_2 = Room.new(2, [3, nil, nil, 1], "You are in the room 2", "sword")
room_3 = Room.new(3, [nil, 4, 2, nil], "You are in the room 3")
room_4 = Room.new(4, [nil, false, nil, 3], "You are in the room 4")
room_5 = Room.new(5, [0, 6, nil, nil], "You are in the room 5")
room_6 = Room.new(6, [nil, 7, nil, 5], "You are in the room 6", "gun")
room_7 = Room.new(7, [8, nil, nil, 6], "You are in the room 7", "programmer")
room_8 = Room.new(8, [9, nil, 7, nil], "You are in the room 8")
room_9 = Room.new(9, [4, nil, nil, 2], "You are in the room 9")

player_1 = Player.new("Lara")

my_rooms = [room_0, room_1, room_2, room_3, room_4, room_5, room_6, room_7, room_8, room_9]

my_game = Game.new(player_1, my_rooms)

my_game.play

my_saved_game = SavedGame.new(my_game.player, my_game.rooms, my_game.current_room, my_game.direction)

my_saved_game.play
