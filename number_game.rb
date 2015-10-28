def game
	puts "What's your name?"
	name = gets.chomp
	puts "Hello #{name} !"

	user_number = 0
	computer_number = rand(1..100)
	counter = 0

	while user_number != computer_number
		puts "Which number am I thinking?"
		user_number = gets.chomp.to_i
		if user_number > computer_number
			puts "The number is lower!"
		elsif user_number < computer_number
			puts "The number is higher!"
		end
		counter += 1
	end

	puts "Correct!" if user_number == computer_number


end

game
