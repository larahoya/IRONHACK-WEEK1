class Player
	
	attr_reader :name

	def initialize(name)
		@name = name
		@objects = []
	end

end

class Room

	attr_reader :number, :other_rooms, :initial_description

	def initialize(number,other_rooms, initial_description)
		@number = number
		@other_rooms = other_rooms
		@initial_description = initial_description
	end
end

class Game
	def initialize(player,rooms)
		@player = player
		@rooms = rooms
		@current_room = @rooms[0].number
	end

	def play
		puts @rooms[@current_room].initial_description
		n = nil
		puts "Select your next move N/E/S/W"
		user_input = gets.chomp.upcase
		
		case user_input
		when 'N'
			n = 0
		when 'E'
			n = 1
		when 'S'
			n = 2
		when 'W'
			n = 3
		else
			puts "Incorrect move!"
		end
		
		if @rooms[@current_room].other_rooms[n] == nil
			puts "You can't do this move!"
			play
		elsif
			@rooms[@current_room].other_rooms[n] == false
			puts "YOU WIN!"
		else
			@current_room = @rooms[@current_room].other_rooms[n]
			play
		end
	end
end

room_0 = Room.new(0, [1, nil, nil, nil], "You are in the room 0")
room_1 = Room.new(1, [nil, 2, 0, nil], "You are in the room 1")
room_2 = Room.new(2, [3, nil, nil, 1], "You are in the room 2")
room_3 = Room.new(3, [nil, 4, 2, nil], "You are in the room 3")
room_4 = Room.new(4, [nil, false, nil, 3], "You are in the room 4")

player_1 = Player.new("Lara")

my_game = Game.new(player_1, [room_0, room_1, room_2, room_3, room_4])

my_game.play
