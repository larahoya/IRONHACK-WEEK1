module Photo

	def take_photo
		puts "Photo taken in #{operative_system}"
	end

end

module PrintTime

	def print_time
		puts Time.now
	end

end




class Device
  
	attr_reader :operative_system
	include PrintTime

  def initialize(operative_system, inches)
  	@operative_system = operative_system
  	@inches = inches
  end

end

class Agenda

	attr_reader :contacts

	def initialize
		@contacts = {}
	end

	def add_contact(name, telephone_number)
  	@contacts[name] = telephone_number
  end

end

class Phone < Device
  
	include Photo

  def initialize(operative_system, inches, agenda)
  	super(operative_system, inches)
  	@agenda = agenda
  end

  def new_contact(name, telephone_number)
  	@agenda.add_contact(name,telephone_number)
  end

  def read_contact(input_name)
  	@agenda.contacts.find do |name, telephone_number|
  		name == input_name
  		puts "#{name}: #{telephone_number}"
    end
  end

  def call_contact(input_name)
    @agenda.contacts.find do |name, telephone_number|
    	name == input_name
    	puts "Calling #{name}..."
    end
  end

end

class Laptop < Device

	include Photo

	def initialize(operative_system, inches, touchable)
		super(operative_system, inches)
		@touchable = touchable
	end

end

class SmartWatch < Device

	def print_time
		puts "*** #{Time.now} ***"
	end

end

class Microwave

include PrintTime

	def initialize(potency)
		@potency = potency
	end

	def heat
		puts "Heating"
	end

end

my_phone = Phone.new("android", 10, Agenda.new)
my_phone.new_contact("Lara", 111111111)
my_phone.read_contact("Lara")
my_phone.call_contact("Lara")
my_phone.take_photo

my_laptop = Laptop.new("Linux", 10, true)
my_laptop.take_photo

smartwatch = SmartWatch.new("android", 10)

microwave = Microwave.new(100)

objects = [my_phone, my_laptop, smartwatch, microwave]

objects.each {|object| object.print_time}

