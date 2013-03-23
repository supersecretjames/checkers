#REV: I'm going to come clean right away and admit I've been drinking
#REV: I probaby would have held off a little more but you seemed so ambivalent
#REV: about the review process, and I for the last two weeks I have
#REV: stopped dividing work and recreation. We'll see how this goes

require 'board'
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
			@board.commit_move(move) #REV: 'commit'--inspired by git?
      @board.king_promote #REV: ambiguous indenting! blargh!
			@players.reverse!
		end
	end

end

g = Checkers.new("Doony", "Soy")
g.play
#REV: shit I can't require anything. blaming it on Windows