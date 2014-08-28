module Hangman
require 'yaml'
class Game
attr_accessor :already_guessed, :tries_left
	def initialize(filename="5desk.txt", min=5, max=12)
		@file = File.open(filename) {|file| file.readlines}
		@dictionary = clean_file(@file).select {|word| word.length >= min && word.length <= max }
		@secret_word = randomizer(@dictionary)
		@tries_left = 10
		@display = Display.new(@secret_word, @tries_left)
		@lose = false
		@win = false
		@already_guessed = []
		@letters_left = @secret_word.length
	end
	
	def clean_file(input)
		output = []
		input.each do |line|
			if line.match('<pre class="cols">')
				output = line.gsub(/\<[^>]+\>|[^a-zA-Z]/, ' ').downcase.split(' ')
			end
		end
		output
	end
	
	def randomizer(input)
		input[rand(input.length)]
	end
	
	def status
		print "Letters guessed: ", @already_guessed.sort.join(", "), "\n"
		puts @display.show
		print @tries_left, " tries remaining \n"
	end
	
	def newgame
		puts "Welcome to Hangman! Load game (Y/N)?"
		self.load if gets.chomp.match(/^[yY]*/)
		until @win || @lose do
			self.status
			guess = self.input
			counter = 0
				@secret_word.chars.to_a.each_with_index do |letter, position|
					if guess == letter
					@display.update(position, letter)
						counter += 1
						@letters_left -= 1
					end
				end
			@tries_left -= 1 if counter == 0
			@lose = true if @tries_left == 0
			@win = true if @letters_left == 0
		end
		puts "You win!" if @win
		puts "You lose! The word was:" if @lose
		puts @secret_word
		puts "Thanks for playing!"
	end
	
	def input
		ready = false
		until ready
			puts "Enter 'save', or guess a letter:"
			guess = gets.chomp
			if guess.downcase == "save"
				self.save
			elsif guess.match(/^[a-zA-Z]$/)
				guess.downcase!
				if @already_guessed.include? guess
					puts "Already guessed!"
				else
				@already_guessed << guess
				ready = true
				end
			else
				puts "Invalid input, try again"
			end
		end
		guess
	end
	
	def save
		savestate = YAML::dump(self)
		file = File.open("hangman_savestate.txt", "w")
			file.puts savestate
		file.close
		puts "Saved!"
	end
	
	def load
		if File.exists? ("hangman_savestate.txt")
			file = File.open("hangman_savestate.txt", "r")
				savestate = file.read
			YAML::load(savestate)
		else
			puts "No file to load!"
		end
	end
	
end

class Display
attr_accessor :show
	def initialize(word, tries_left)
		@tries_left = tries_left
		@show = ""
		word.length.times { @show << "_" }
		@secret_word = word
	end
	
	def update(position, letter)
		@show[position] = letter
	end
end

end

a = Hangman::Game.new
p a.newgame