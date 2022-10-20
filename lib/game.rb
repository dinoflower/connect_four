# frozen_string_literal: true

require_relative 'player'

# game portion of connect four
class Game
  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def check_board(move)
    return false unless play_tree(move) # something about lines
  end
end

# okay, you make a move and (if valid) it saves that move and its adjacent vertices
# which means the move knows what's near it and whether that's occupied
# and with what
