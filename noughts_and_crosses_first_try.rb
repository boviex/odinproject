module NoughtsAndCrosses
	class Game
	attr_accessor :player_state, :game_board
		def initialize
			@game_board = Board.new
			@coord = nil
			@player_state = rand(2)==1 ? "X" : "O"
			@stop = false
		end
		
		def welcome #starts game, resets afterwards
			newgame = true
			puts "Welcome to noughts and crosses."
			until newgame == false
				self.play
				puts "New game (Y/N)?"
				unless gets.chomp =~ /^[yY]/
					newgame = false
					puts "Thanks for playing!"
				end
				@game_board.reset
				@stop = false
				@player_state = rand(2)==1 ? "X" : "O"
			end
		end
		
		def play #controls actual game
			puts @game_board.status
			puts "#{@player_state} moves first."
			until @stop
				self.turn
				if game_over?
					@stop = true 
				elsif @game_board.full?
					@player_state = "Nobody"
					@stop = true
				else
					self.change
					puts "#{@player_state} to play"
				end
			end
			puts "#{@player_state} wins!"
		end
		
		def turn #controls each turn, ends when grid is updated
			turn_state = "start"
			until turn_state == "stop"
				if self.get_move
					turn_state = "stop"
					if @game_board.update_grid(@coord, @player_state)
						puts @game_board.status
					else
						turn_state = "start"
					end
				end	
			end
		end
		
		def change #change players
			if @player_state == "O"
				@player_state = "X"
			elsif @player_state == "X"
				@player_state = "O"
			end
		end
		
		def get_move #gets user coordinate, passes it on if valid
			puts "Enter a cell (e.g. a1)"
			move = gets.chomp
			if move =~ /^[a-cA-C][1-3]$/
			self.map_move(move.downcase)
			
			return true
			else
			puts "Invalid cell, try again"
				false
			end
		end
		
		def map_move(move) #converts to coordinates, saves as instance variable
			mapper = { "a" => 0, "b" => 1, "c" => 2 }
			@coord = [mapper[(move[0])],move[1].to_i-1]
		end
			
		def game_over?
			return @game_board.check_winner
		end
	end
	
	class Board
		def initialize
			@grid = [[" "," "," "],[" "," "," "],[" "," "," "]]
		end
		
		def reset #allows new game
			@grid = [[" "," "," "],[" "," "," "],[" "," "," "]]
		end
		
		def update_grid(coords, player) #updates grid if coordinates are valid
			col = coords[0]
			row = coords[1]
			if @grid[row][col] == " "
				@grid[row][col] = player
				return true
			else
				puts "Cell already played. Try again:"
				return false
			end
		end
		
		def print_grid #prints a grid
			top = " |A|B|C|"
			divider = "-+-+-+-+"
			row1 = "1|#{@grid[0][0]}|#{@grid[0][1]}|#{@grid[0][2]}|"
			row2 = "2|#{@grid[1][0]}|#{@grid[1][1]}|#{@grid[1][2]}|"
			row3 = "3|#{@grid[2][0]}|#{@grid[2][1]}|#{@grid[2][2]}|"
			[top,divider,row1,divider,row2,divider,row3,divider]
		end
		
		def check_winner #any of the win conditions
			if winning_row? || winning_col? || winning_diag?
				return true
			else
				return false
			end
		end
		
		def full? #will only be called if check_winner is false
			@grid.each do |row|
				return false if row.include? " "
			end
			true
		end
		
		def winning_row? #ugly, but it works
			@grid.each do |row| #for each row
				if row.include? " " #if the row is not full
					false
				elsif (row.include? "X") && (row.include? "O") #or if more than one player is in that row
						false
				else #game is over if one side fills that row
						return true
				end
			end
			false
		end
		
		def winning_col? #ugly, but at least it's short
			@grid = @grid.transpose
			val = self.winning_row?
			@grid = @grid.transpose
			val
		end
		
		def winning_diag? #good thing there's only two diagonals
			unless @grid[1][1] == " "
				if (@grid[1][1] == @grid[0][0] && @grid[1][1] == @grid[2][2])
					return true
				elsif (@grid[1][1] == @grid[2][0] && @grid[1][1] == @grid[0][2])
					return true
				else
					return false
				end
			end
		end
		
		def status #this is not very useful, actually
			puts print_grid
		end
	end
	
end

game_1 = NoughtsAndCrosses::Game.new

game_1.welcome


#  game board:
#   |A|B|C|
#  -+-+-+-+
#  1| | | |
#  -+-+-+-+
#  2| | | |
#  -+-+-+-+
#  3| | | |
#  -+-+-+-+