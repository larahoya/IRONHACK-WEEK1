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
    puts "----------------"
    @items.each do |name, quantity|
      puts "#{quantity} #{name} #{@prices[name]}"
    end	
    puts "----------------"
  end

end

class RegisterCash

  def initialize(cart)
    @cart = cart
    @total_cost = 0
  end

  def apply_discounts
    if @cart.items["apple"]
      apple_discount if @cart.items["apple"] > 1
    end
    if @cart.items["orange"]
      oranges_discount if @cart.items["orange"] > 2
    end
    if @cart.items["grapes"]
      banana_for_free if @cart.items["grapes"] == 4
    end
    if @cart.items["watermelon"]
      sunday_watermelon if Time.now.sunday?
    end
    
  end

  def apple_discount
    apple_number = @cart.items["apple"]
    @cart.prices["apple"] = (apple_number/2)*(@cart.prices["apple"]/apple_number)
  end

  def oranges_discount
    orange_price = (@cart.prices["orange"] / @cart.items["orange"])
    oranges_number_to_pay = ((@cart.items["orange"]/3)*2)+(@cart.items["orange"]%3)
    @cart.prices["orange"] = orange_price*oranges_number_to_pay
  end

  def banana_for_free
  	if @cart.items["banana"]
      @cart.items["banana"] += 1
    else
  	  @cart.items["banana"] = 1
      @cart.prices["banana"] = 0
    end
  end

  def sunday_watermelon
    @cart.prices["watermelon"] *= 2
  end

  def calculate_cost
    @cart.prices.each do |name, cost|
      @total_cost += cost
    end	
    @total_cost
  end

  def calculate_final_cost
    apply_discounts
    calculate_cost
  end 

  def show_cost
  	puts "Total price = #{calculate_cost}"
  	@total_cost = 0
    puts "Final price = #{calculate_final_cost}"
    @cart.show_cart
  end

end

class Item

  attr_reader :name, :price

  def initialize(name, prices)
    @name = name
    @prices = prices
    @price = check_price
  end

  def check_price
    actual_month = Time.now.mon
    
    case actual_month
    when 3,4,5
    	@prices[0]
    when 6,7,8
    	@prices[1]
    when 9,10,11
    	@prices[2]
    when 12,1,2
    	@prices[3]
    end
    
  end

end

orange = Item.new("orange", [5,2,5,5])
apple = Item.new("apple", [10,10,15,12])
grapes = Item.new("grapes", [15,15,15,15])
banana = Item.new("banana", [20,20,20,21])
watermelon = Item.new("watermelon", [50,50,50,50])

my_cart = ShoppingCart.new
my_cart.add_item(orange)
my_cart.add_item(orange)
my_cart.add_item(orange)
my_cart.add_item(apple)
my_cart.add_item(apple)
my_cart.add_item(grapes)
my_cart.add_item(grapes)
my_cart.add_item(grapes)
my_cart.add_item(grapes)
my_cart.add_item(watermelon)


my_register_cash = RegisterCash.new(my_cart)
my_register_cash.show_cost





