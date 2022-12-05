# frozen_string_literal: true

require_relative 'board'

# players of connect four game
class Player
  ADJACENT_TILES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]].freeze

  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  def won?
    @board.check_plays(@color)
  end
end
