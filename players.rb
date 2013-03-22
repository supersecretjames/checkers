require './checkers'
require './board'

class Player
	attr_reader :name

	def initialize(name)
		@name = name
	end

end

class HumanPlayer < Player

	def make_move(board) # Returns array with start and finish coordinates.
		move = get_move(board)
		if board.valid_move?(move) 
			return move
		else
			puts "Sorry, invalid move. Please try again."
			make_move(board)
		end
	end

	def get_move(board) 
		puts 'Please pick a piece (row, column) to move ("0, 1" for example).'
		from_pos = gets.chomp 
		from_pos = [from_pos[0].to_i, from_pos[-1].to_i]


		puts 'Please enter the destination for your piece row, column.'
		to_pos = gets.chomp
		to_pos = [to_pos[0].to_i, to_pos[-1].to_i]

		return [from_pos, to_pos]
	end
end

class ComputerPlayer < Player

end
