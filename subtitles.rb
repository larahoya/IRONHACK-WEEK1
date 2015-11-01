require 'pry'
require 'Time'

class File

	attr_reader :subtitles

	def initialize(file)
		@file = file
		@subtitles = []
	end

  def read_file
    IO.read(@file).split("\n\n").map do |subt|
      subt.split("\n")
    end
  end

  def divide_time
  	file_subtitles = read_file
  	for n in 0...file_subtitles.size
      file_subtitles[n][1]= file_subtitles[n][1].split("-->")
    end
    file_subtitles
  end

  def create_subtitles
  	file_subtitles = divide_time
    file_subtitles.each do |subt|
    	@subtitles.push(Subtitle.new(subt[0], subt[1][0], subt[1][1], subt[2]))
    end
  end

  def change_subtitles_time(time)
  	@subtitles.map do |subtitle|
  		subtitle = subtitle.change_time(2500)
  	end
  end

  def get_text
  	text = ""
  	@subtitles.each do |subtitle|
  		text += "#{subtitle.number}\n#{subtitle.time_in} --> #{subtitle.time_out}\n#{subtitle.text}\n\n"
  	end
  	text
  end

  def write_file
  	IO.write(@file, get_text)
  end

end

class Subtitle

  attr_reader :number, :time_in, :time_out, :text

  def initialize(number, time_in, time_out, text)
  	@number = number
  	@time_in = time_in
  	@time_out = time_out
  	@text = text
  end

  def change_time(time)
    str_to_datatime
    add_time(time)
    datatime_to_str
  end
  
  def str_to_datatime
  	@time_in = Time.parse(@time_in)
  	@time_out = Time.parse(@time_out)
  end

  def add_time(milliseconds)
  	seconds = milliseconds/1000.0
  	@time_in = @time_in + seconds
  	@time_out = @time_out + seconds
  end

  def datatime_to_str
  	@time_in = @time_in.strftime("%T,%L")
  	@time_out = @time_out.strftime("%T,%L")
  end

end


my_file = File.new("subtitles.srt")
my_file.create_subtitles

my_file.change_subtitles_time(2500)
my_file.write_file


