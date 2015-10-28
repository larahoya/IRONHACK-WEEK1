class Car

	def initialize(sound,engine)
		@sound = sound
		@engine = engine
	end

	def make_car_noise
		puts "#{@sound} #{@engine.sound}"
	end

end

class Engine

	attr_reader :sound

	def initialize(sound)
		@sound = sound
	end

end

class ElectricEngine < Engine

	def initialize(sound, battery)
		super(sound)
		@battery = battery
	end

end

Car.new("BROM", Engine.new("BROOM")).make_car_noise
Car.new("BROM", ElectricEngine.new("BROOOOOM", "1.9")).make_car_noise