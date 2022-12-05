# frozen_string_literal: true

require_relative 'board'

# players of connect four game
class Player
  ADJACENT_TILES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]].freeze

  def initialize(name, color)
    @name = name
    @color = color
  end

  def won?; end
end
