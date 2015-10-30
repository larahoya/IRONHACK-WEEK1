require 'pry'

class ShoppingCart

	attr_reader :items, :prices

	def initialize
		@items = {}
		@prices = {}
	end

	def add_item(item)
		if @items[item.name]
				@items[item.name] += 1
				@prices[item.name] += item.price
		else
			@items[item.name] = 1
			@prices[item.name] = item.price
		end
	end

	def show_cart
		@items.each do |name, quantity|
			puts "#{quantity} #{name} #{@prices[name]}"
		end	
	end

end

class RegisterCash

	attr_reader 

	def initialize(cart)
		@cart = cart
		@total_cost = 0
	end

	def apply_discounts
		apple_discount
		grapes_discount
		banana_for_free
	end

	def apple_discount
		apple_number = @cart.items["apple"]
		@cart.prices["apple"] = (apple_number/2)*(@cart.prices["apple"]/apple_number)
	end

	def grapes_discount
		grapes_number = @cart.items["grapes"]
		grapes_number = (grapes_number/3 + 1)*2 if grapes_number > 2
		@cart.prices["grapes"] = @cart.prices["grapes"]*grapes_number 
	end

	def banana_for_free
	end

	def calculate_cost
		@cart.prices.each do |name, cost|
			@total_cost += cost
		end	
		@total_cost
	end 

	def show_cost
		puts "Total price = #{calculate_cost}"
	end

end

class Item

	attr_reader :name, :price

	def initialize(name, price)
		@name = name
		@price = price
	end

end

orange = Item.new("orange", 5)
apple = Item.new("apple", 10)
grapes = Item.new("grapes", 15)
banana = Item.new("banana", 20)
watermelon = Item.new("watermelon", 50)

my_cart = ShoppingCart.new
my_cart.add_item(orange)
my_cart.add_item(orange)
my_cart.add_item(orange)
my_cart.add_item(apple)
my_cart.add_item(grapes)
my_cart.add_item(apple)
my_cart.add_item(watermelon)


my_register_cash = RegisterCash.new(my_cart)
my_register_cash.apply_discounts
my_register_cash.show_cost





