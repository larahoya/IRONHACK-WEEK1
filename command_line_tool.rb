class User

	attr_reader :name, :password

	def initialize(name, password)
		@name = name
		@password = password
	end

end

class Tool

	def initialize(user, input_password)
		@user = user
		@input_password = input_password
		@user_text = ""
	end

	def check_password
		@input_password == @user.password
	end

	def get_text
		puts "Enter a text"
		@user_text = gets.chomp
	end

	def get_words
		@user_text = @user_text.split(" ")
	end

	def count_words
		@user_text.reduce(0) do |sum,word|
			sum += 1
		end
	end

	def show_number
		puts count_words
	end

	def start_tool
		check_password
		get_text
		get_words
		show_number
	end

end


user_1 = User.new("Lara", 123)
user_2 = User.new("Pedro", 456)

Tool.new(user_1, 123).start_tool