# frozen_string_literal: true

require_relative 'game'
require_relative 'player'

# board to store and display connect four game
class Board
  ROWS = 6
  COLUMNS = 7
  attr_accessor :board_array

  def initialize
    @board_array = Array.new(ROWS) { Array.new(COLUMNS) }
  end

  def check_board(row, column)
    return if @board_array[(row + 1)..].any? { |arr| arr[column].nil? }

    return [row, column] if board_array.dig(row, column).nil?
  end

  def save_play(player_move)
    @board_array[player_move[0]][player_move[1]] = 'Y'
  end

  def check_plays(player_color)
    return false unless horizontal_win(player_color) || vertical_win(player_color) || diagonal_win(player_color)
  end
end
