# frozen_string_literal: true

require_relative 'game'

# board to store and display connect four game
class Board
  attr_accessor :board_array

  def initialize
    @board_array = Array.new(6) { Array.new(7) }
  end

  def check_board(row, column)
    return if @board_array[(row + 1)..].any? { |arr| arr[column].nil? }

    return [row, column] if board_array.dig(row, column).nil?
  end

  def save_play(player_move)
    @board_array[player_move[0]][player_move[1]] = 'Y'
  end
end
