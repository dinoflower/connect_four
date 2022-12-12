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
    6.times do |row|
      7.times do |column|
        @board.check_lines(row, column, @color)
      end
    end
  end
end
