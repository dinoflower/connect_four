# frozen_string_literal: true

# board to store and display connect four game
class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end
end