class Home

	attr_reader :name, :city, :capacity, :price

	def initialize(name, city, capacity, price)
		@name = name
		@city = city
		@capacity = capacity
		@price = price
	end

	def <=> other
		price <=> other.price
	end
end

homes = [
	Home.new("Nizar's place", "San Juan", 2, 42),
	Home.new("Fernando's place", "Sevilla", 5, 47),
	Home.new("Josh's place", "Pittsburg", 3, 41),
	Home.new("Gonzalo's place", "Malaga", 2, 45),
	Home.new("Ariel's place", "San Juan", 4, 49),
	Home.new("Pedro's place", "Madrid", 1, 50),
	Home.new("Maria's place", "Sevilla", 3, 47),
	Home.new("Carolina's place", "Valencia", 4, 30),
	Home.new("Lara's place", "Barcelona", 2, 35),
	Home.new("Luis's place", "Madrid", 4, 49),
]

#list of homes
def list_of_homes(array)	
	array.each do |home|
		puts "#{home.name} in #{home.city} \nPrice: $#{home.price} a night\n\n"
	end
end

#average capacity
total_capacity = homes.reduce(0.0) do |sum, home|
	sum += home.capacity
end
puts "The average capacity is: #{total_capacity/homes.length}"

#average price
total_price = homes.reduce(0.0) do |sum, home|
	sum += home.price
end
puts "The average price is: #{total_price/homes.length}"

#sort by price
sorted_by_price = homes.sort #do |home1, home2|
	#home1.price <=> home2.price
#end

list_of_homes(sorted_by_price)

#select by city
def select_by_city(array, selected_city)
	selected = array.select do |home|
		home.city == selected_city
	end
	list_of_homes(selected)
end

select_by_city(homes,"Madrid")

#select by price
def select_by_price(array, selected_price)
	selected_home = array.find do |home|
		home.price == selected_price
	end
	puts "#{selected_home.name} in #{selected_home.city} \nPrice: $#{selected_home.price} a night\n\n"
end

select_by_price(homes,49)



