# frozen_string_literal: true

# players of connect four game
class Player
  ADJACENT_TILES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]].freeze

  def initialize(game, color)
    @game = game
    @color = color
    @board = game.board
  end
end
