class Car

	def initialize(sound)
		@sound = sound
		@cities = "file.txt"
		IO.write(@cities,"")
	end

	def make_noise
		puts @sound
	end

	def self.noise(one_car)
  		2.times {one_car.make_noise}
	end

	def add_city(city)
		list = "#{IO.read(@cities)}\n#{city}" 
		IO.write(@cities, list)
	end

	def cities
		puts IO.read(@cities)
	end

end

class RacingCar < Car

	def initialize
		super("BROOOOOM")
	end

end

car_1 = Car.new("Broom")

car_1.add_city("Madrid")
car_1.add_city("Barcelona")

car_2 = RacingCar.new
car_2.make_noise