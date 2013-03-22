require './board'
require './players'

class Checkers
	attr_reader :players, :board
	
	def initialize(player1, player2)
		@board = Board.new
		@players = [HumanPlayer.new(player1), HumanPlayer.new(player2)]
	end

	def play
		until @board.over? 
			@board.print_board
			move = @players[0].make_move(@board.dup)
			@board.commit_move(move)
			@players.reverse!
		end
	end

end