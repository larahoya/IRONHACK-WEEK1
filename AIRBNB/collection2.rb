class Home

  attr_reader :name, :city, :capacity, :price

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end

end

class HomeContainer

  attr_reader :list_of_homes, :my_list

  def initialize
    @list_of_homes = []
    @my_list = []
    @user_selection = ""
  end

  def add_home(home)
    @list_of_homes.push(home)
  end

  def menu
    @my_list = @list_of_homes
    get_list
    get_user_input
    choice(@user_selection)
  end
 
  def get_user_input
    puts "\nFilter by maximun price(P) \nSelect by city(T) \nFilter by city(C) \nSort from lower price(L) \nSort from higher price(H) \nExit (E)"
    @user_selection = gets.chomp.upcase
  end

  def choice(selection)
    case selection
    when "T"
      select_by_city
      get_list
    when "L"
      sort_low_to_high
      get_list
    when "H"
      sort_high_to_low
      get_list
    when "P"
      filter_by_price
      get_list
    when "C"
      filter_by_city	
      get_list
    when "E"
      return
    else
      puts "Incorrect choice"
    end
    get_user_input
    choice(@user_selection)
  end

  def get_list
    @my_list.each do |home|
      puts "#{home.name} in #{home.city} Price: $#{home.price} a night"
    end
  end

  def sort_low_to_high
    @my_list = @my_list.sort do |home1,home2|
      home1.price <=> home2.price
    end
  end

  def sort_high_to_low
    @my_list = @my_list.sort do |home1,home2|
      home2.price <=> home1.price
    end
  end

  def filter_by_city
    puts "\nSelect a city"
    user_city = gets.chomp
    @my_list = @my_list.select do |home1|
      home1.city.downcase == user_city.downcase
    end
  end

  def filter_by_price
    puts "\Select maximun price"
    user_price = gets.chomp.to_i
    @my_list = @my_list.select do |home1|
      home1.price <= user_price
    end
  end

  def select_by_city
    puts "\nSelect a city"
    user_city = gets.chomp
    city_selection = @list_of_homes.select do |home1|
      home1.city.downcase == user_city.downcase
    end
    number=city_selection.length
    puts "\nYou have #{number} places in #{user_city}.\n"
  end

end

nizar = Home.new("Nizar's place", "San Juan", 2, 42)
fernando = Home.new("Fernando's place", "Sevilla", 5, 47)
josh = Home.new("Josh's place", "Pittsburg", 3, 41)
gonzalo = Home.new("Gonzalo's place", "Malaga", 2, 45)
ariel = Home.new("Ariel's place", "San Juan", 4, 49)
pedro = Home.new("Pedro's place", "Madrid", 1, 50)
maria = Home.new("Maria's place", "Sevilla", 3, 47)
carolina = Home.new("Carolina's place", "Valencia", 4, 30)
lara = Home.new("Lara's place", "Barcelona", 2, 35)
luis = Home.new("Luis's place", "Madrid", 4, 49)

my_homes = HomeContainer.new
my_homes.add_home(nizar)
my_homes.add_home(fernando)
my_homes.add_home(josh)
my_homes.add_home(gonzalo)
my_homes.add_home(ariel)
my_homes.add_home(pedro)
my_homes.add_home(maria)
my_homes.add_home(carolina)
my_homes.add_home(lara)
my_homes.add_home(luis)

my_homes.menu
