require './checkers'
require './board'
require './players'

class Board
	attr_reader :board
	
	def initialize
		@board = Board.set_board

	end

	def self.set_board
		@board = Array.new(8) {Array.new(8)}
		
		@board.each_with_index do |row, row_index|
			row.each_with_index do |column, column_index| 
				if (row_index == 0 || row_index == 2) && column_index.odd?
					@board[row_index][column_index] = Peon.new(:red) 
				elsif row_index == 1 && column_index.even?
					@board[row_index][column_index] = Peon.new(:red) 
				elsif (row_index == 5 || row_index == 7) && column_index.even?
					@board[row_index][column_index] = Peon.new(:white)
				elsif row_index == 6 && column_index.odd?
					@board[row_index][column_index] = Peon.new(:white)
				end	
			end
		end
		@board
	end

	def valid_move?(move)
		true
	end

	def commit_move(move) #TODO kill pieces that get jumped
		from_pos = move[0]
		to_pos = move[1]

		board[to_pos[0]][to_pos[1]] = board[from_pos[0]][from_pos[1]]
		board[from_pos[0]][from_pos[1]] = nil

	end

	def over?
		false
	end

	def print_board
		top = (0..7).to_a.join(' ').rjust(17)
		puts top
		board_string = ''
		@board.each_with_index do |row, row_index|
			board_string << row_index.to_s + ' ' 
			row.each_with_index do |square, col_index|
				case square
				when nil
					board_string << '  '
				when Peon
					board_string << 'p '
				when King 
					board_string << 'K '
				end
				board_string << "\n" if col_index == 7
			end
		end
		puts board_string
	end

end

class Piece
attr_reader :color

	def initialize(color)
		@color = color
	end

end

class Peon < Piece

end

class King < Piece

end