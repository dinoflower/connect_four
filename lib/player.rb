# frozen_string_literal: true

require_relative 'board'

# players of connect four game
class Player
  attr_reader :name, :color

  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  def won?
    @board.check_plays(@color)
  end
end
