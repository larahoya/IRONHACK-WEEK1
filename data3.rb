class Car

	attr_reader :wheels, :sound

	def initialize(sound, wheels)
		@sound = sound
		@wheels = wheels
	end

end

class Bycicle

	attr_reader :wheels, :sound

	def initialize(sound, wheels)
		@sound = sound
		@wheels = wheels
	end

end

class CountingWheels

	def initialize(array)
		@array = array
	end

	def count_wheels
		@array.reduce(0) do |number, vehicle|
			number + vehicle.wheels
		end
	end

end

class Noises

	def initialize(array)
		@array = array
	end

	def make_noise
		@array.each do |vehicle|
			puts vehicle.sound
		end
	end

end

my_array = [Car.new("BROOM", 4), Bycicle.new("BROM", 2)]

puts CountingWheels.new(my_array).count_wheels
Noises.new(my_array).make_noise