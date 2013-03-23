require './checkers'
require './board'
require './players'

class Board
	attr_reader :board

	def initialize
		@board = Board.set_board
	end

	def self.set_board
		@board = Array.new(8) {Array.new(8)} #REV: mmm, clean

		@board.each_with_index do |row, row_index|
			row.each_with_index do |column, column_index|
				if (row_index == 0 || row_index == 2) && column_index.odd?
					@board[row_index][column_index] = Peon.new(:red) #REV: haha, 'Peon'
				elsif row_index == 1 && column_index.even?
					@board[row_index][column_index] = Peon.new(:red)
				elsif (row_index == 5 || row_index == 7) && column_index.even?
					@board[row_index][column_index] = Peon.new(:white)
				elsif row_index == 6 && column_index.odd? #REV: I wish I had thought of 'Peon'
					@board[row_index][column_index] = Peon.new(:white)
				end
			end #REV: I personally prefer hardcoding something like
		end #REV: this, seem the starting positions are sort of arbitrary
		@board #REV: anyway
	end

	def valid_move?(move, player_color)
		from_pos, to_pos = move[0], move[1]
    start_square = board[from_pos[0]][from_pos[1]]
    to_square = board[to_pos[0]][to_pos[1]]

    if start_square.nil? || start_square.color != player_color
      return false
    end

    if to_square.nil? &&
      valid_dests(from_pos, player_color).include?(to_pos)
      return true
    else
      return false
    end
	end

  def valid_dests(start_pos, player_color) # TODO Refactor DRY DRY DRY
    start_r, start_c = start_pos[0], start_pos[1] #REV: I sing that
    start = board[start_r][start_c] #REV: to myself after I get out
    dest = [] #REV: of the shower everyday
    #empty? method
    if (start.class == Peon && start.color == :red) || start.class == King
      if board[start_r + 1][start_c - 1].nil?
        dest << [start_r + 1, start_c - 1]
      else
        if board[start_r + 1][start_c - 1].color == :white &&
          board[start_r + 2][start_c - 2].nil?
          dest << [start_r + 2, start_c - 2]
        end
      end
      if board[start_r + 1][start_c + 1].nil?
        dest << [start_r + 1, start_c + 1]
      else
        if board[start_r + 1][start_c + 1].color == :white &&
          board[start_r + 2][start_c + 2].nil?
          dest << [start_r + 2, start_c + 2]
        end
      end
    end

    if (start.class == Peon && start.color == :white) || start.class == King
      if board[start_r - 1][start_c - 1].nil?
        dest << [start_r - 1, start_c - 1]
      else
        if board[start_r - 1][start_c - 1].color == :red &&
          board[start_r - 2][start_c - 2].nil?
          dest << [start_r - 2, start_c - 2]
        end
      end
      if board[start_r - 1][start_c + 1].nil?
        dest << [start_r - 1, start_c + 1]
      else
        if board[start_r - 1][start_c + 1].color == :red &&
          board[start_r - 2][start_c + 2].nil?
          dest << [start_r - 2, start_c + 2]
        end
      end
    end
    dest.map.select { |r, c| r.between?(0, 7) && c.between?(0, 7)}
  end


	def commit_move(move)
		from_pos, to_pos = move[0], move[1]
    from_r, from_c = from_pos[0], from_pos[1]
    to_r, to_c = to_pos[0], to_pos[1]

    board[to_r][to_c] = board[from_r][from_c] # Move piece
		board[from_r][from_c] = nil

    if ((from_r - to_r).abs == 2) || ((from_c - to_c).abs == 2)
      board[(from_r + to_r)/2][(from_c + to_c)/2] = nil # Remove jumped piece
    end

    #TODO Chain jumping goes here

	end

	def over?
    red = 0
    white = 0
    @board.each do |rows|
      rows.each do |item|
        next if item.nil?
        red += 1 if item.color == :red
        white += 1 if item.color == :white
      end
    end
    if red == 0 or white == 0 #REV: doesn't really need to be
      puts "Game over!" #REV: counted, right?
      return true
    else
      return false
    end
	end

  def king_promote
    @board[0].each_with_index do |square, index|
      if (square.class == Peon && square.color == :white)
        puts "White has a king!" #REV: epic
        @board[0][index] = King.new(:white)
      end
    end

    @board[7].each_with_index do |square, index|
      if (square.class == Peon && square.color == :red)
        puts "Red has a king!"
        @board[7][index] = King.new(:red)
      end
    end
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
          if square.color == :red
					  board_string << 'r '
          else
            board_string << 'w '
          end
				when King
          if square.color == :red
					  board_string << 'rK'
          else
            board_string << 'wK'
          end
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