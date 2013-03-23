require './board'
require './players'

class Checkers
	attr_reader :players, :board

	def initialize(p1, p2)
		@board = Board.new
		@players = [HumanPlayer.new(p1, :red), HumanPlayer.new(p2, :white)]
	end

	def play
		until @board.over?
			@board.print_board
			move = @players[0].make_move(@board.dup)
			@board.commit_move(move)
      @board.king_promote
			@players.reverse!
		end
	end

end
