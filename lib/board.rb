# frozen_string_literal: true

require_relative 'game'

# board to store and display connect four game
class Board
  attr_reader :board_array

  def initialize
    @board_array = Array.new(6) { Array.new(7) }
  end

  def verify_input(row, column)
    return unless row.between?(0, 6) && column.between?(0, 7)
    return if board_array[(row + 1)..].any? { |arr| arr[column].nil? }

    return [row, column] if board_array.dig(row, column).nil?
  end
end
