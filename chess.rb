# encoding: utf-8

class Board #tracks piece positions
		#update - displays the screen
attr_accessor :screen, :game
	def initialize(game)
		@game = game
		@turn_count = 0
		@prev_move = "e5-e7"
		@check = " - CHECK"
		@screen = %Q{
    A B C D E F G H 
  1 r n b k q b n r 1  Turn count: #{@turn_count}
  2 p p p p p p p p 2  Previous move: #{@prev_move}#{@check}
  3   %   %   %   % 3
  4 %   %   %   %   4
  5   %   %   %   % 5
  6 %   %   %   %   6
  7 P P P P P P P P 7
  8 R N B Q K B N R 8
    a b c d e f g h  

  #{@game.current_player} has the move
}
	end
	def status
		puts @screen
	end

	def confirm_move(origin, destination)
		puts "move confirmed!"
	end

	def update
		@prev_move = @game.prev_move
		@game.check? ? @check = " - CHECK" : @check = ""
	end

end

class Player #provides input

end

class Game #admin and rules enforcement
attr_accessor :current_player, :other_player, :board, :gameover, :prev_move
		#self.new
	def initialize
		@current_player = "WHITE"
		@other_player = "black"
		@board = nil
		@gameover = false
		@prev_move = ""
		welcome
		if load?
			load_prompt
		else
			start_game
		end
		
	end

	def welcome #simple message
		puts "Welcome to Chess!"
	end

	def load? #true if yes, false if no
		puts "Load a previous game? (y/n)"
		if gets.chomp.match(/^[yY]/)
			true
		else
			false
		end
	end

	def save_prompt
		puts %Q{
	---------------
Slot 1: save_name
Date: save_date(dd/mm/yy, hh:mm)
	---------------
Slot 2: Adam vs Betty
Date: 30/08/14, 20:38
	---------------
Slot 3: name
Date: N/A
	---------------
Which slot do you want to save? (or enter "back")
				}
		input = gets.chomp.downcase
		if input.match(/back/)
			get_origin
		elsif input.match(/[1-3]/)
			save_game(input)
		else
			puts "Please enter the slot number, or enter 'back'"
			save_prompt
		end
	end

	def save_game(input)
		puts "Sorry, this feature isn't available yet."
		get_origin
	end

	def load_prompt
		puts %Q{
	---------------
Slot 1: save_name
Date: save_date(dd/mm/yy, hh:mm)
	---------------
Slot 2: Adam vs Betty
Date: 30/08/14, 20:38
	---------------
Slot 3: name
Date: N/A
	---------------
Which slot do you want to load? (or enter "back")
				}
		input = gets.chomp.downcase
		if input.match(/back/)
			initialize
		elsif input.match(/[1-3]/)
			load_game(input)
		else
			puts "Please enter the slot number, or enter 'back'"
			load_prompt
		end
	end

	def load_game(input)
		puts "Sorry, this feature isn't available yet."
		initialize
	end

	def start_game
		@board = Board.new(self)
		until @gameover
			turn
		end
	end

	def turn
		@board.status
		get_origin
		#if check_state == "continue" #also not set
		#	@current_player, @other_player = @other_player, @current_player
		#else
			@gameover = true
		#end
	end

	def get_origin
		puts "Please enter the coordinates of the piece you wish to move (e.g. a1):\nBe careful, once 'touched' the piece must be moved.\nYou can also type 'save' or 'resign'."
		input = gets.chomp.downcase
		save_prompt if input.match(/save/)
		unless is_valid_piece?(input)
			puts "That is not a valid coordinate."
			get_origin
		else
			origin = input
			get_destination(origin)
		end
	end

	def get_destination(origin)
		puts "Please enter the destination coordinates (e.g. a1):"
		input = gets.chomp.downcase
		unless is_valid_destination?(origin, input)
			puts "That piece cannot move there."
			get_destination
		else
			@board.confirm_move(origin, input)
		end
	end

	def is_valid_piece?(input)
		false #lol
	end
		def is_valid_destination?(origin, destination)
		false
	end
end

class Piece
attr_accessor :colour
	#@position: its current position
	#@moves: legal moves
	#calcmoves - updates @moves each turn
end

class Pawn < Piece
		
end

class Bishop < Piece

end

class Knight < Piece

end

class Rook < Piece

end

class Queen < Piece

end

class King < Piece

end


Game.new

