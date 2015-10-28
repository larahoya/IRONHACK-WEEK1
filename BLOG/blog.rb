require 'colorize'

class Blog

	def initialize
		@posts = []
		@pages = []
		@current_page = 0
	end

	def add_post(post)
		@posts << post
	end

	def sort_by_date
		@posts = @posts.sort do |post1, post2|
			post1.date <=> post2.date
		end
	end

	def create_pages
		for n in 0..@posts.length/3
			@pages[n] = ""
		end
		post_number = 0
		while post_number < @posts.length
			page_number = post_number/3
			if @posts[post_number].sponsored
				@pages[page_number] += "***** #{@posts[post_number].title} ***** \n********** \n#{@posts[post_number].text } \n----------\n"
			else
				@pages[page_number] += "#{@posts[post_number].title} \n********** \n#{@posts[post_number].text } \n----------\n"
			end
			post_number += 1
		end	
	end

	def menu 
		user_input = gets.chomp.downcase
		if user_input == "p"
			@current_page -= 1 if @current_page > 0 
			publish_page
		elsif user_input == "n"
			@current_page += 1 if @current_page < (@pages.length - 1)
			publish_page
		end

	end

	def publish_page
		system "clear"
		puts @pages[@current_page]
		for n in 1..@pages.length
			if (@current_page + 1)== n
				print "#{n}   ".colorize(:red)
			else
				print "#{n}   "
			end
		end
		puts "> next" if @current_page < @pages.length - 1
		menu
	end

end

class Post

	attr_reader :title, :text, :date, :sponsored

	def initialize(title, text, sponsored=false)
		@title = title
		@text = text
		@date = Time.now
		@sponsored = sponsored
	end

end

my_blog = Blog.new
post_1 = Post.new("Post Title 1", "Post Text 1")
post_2 = Post.new("Post Title 2", "Post Text 2")
post_3 = Post.new("Post Title 3", "Post Text 3")
post_4 = Post.new("Post Title 4", "Post Text 4")
post_5 = Post.new("Post Title 5", "Post Text 5")
post_6 = Post.new("Post Title 6", "Post Text 6")
post_7 = Post.new("Post Title 7", "Post Text 7")
post_8 = Post.new("Post Title 8", "Post Text 8")
my_blog.add_post(post_1)
my_blog.add_post(post_2)
my_blog.add_post(post_3)
my_blog.add_post(post_4)
my_blog.add_post(post_5)
my_blog.add_post(post_6)
my_blog.add_post(post_7)
my_blog.add_post(post_8)
my_blog.sort_by_date
my_blog.create_pages
my_blog.publish_page
