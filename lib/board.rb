# frozen_string_literal: true

require_relative 'game'
require_relative 'player'

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

  def save_play(player_color, player_move)
    @board_array[player_move[0]][player_move[1]] = player_color
  end

  def check_lines(row, column, player_color)
    horizontal_win?(row, column, player_color) || vertical_win?(row, column, player_color) ||
      diagonal_win?(row, column, player_color)
  end

  def horizontal_win?(row, column, player_color)
    return if column > 4

    return true if @board_array[row][column] == player_color && @board_array[row][column + 1] == player_color &&
                   @board_array[row][column + 2] == player_color && @board_array[row][column + 3] == player_color

    false
  end

  def vertical_win?(row, column, player_color)
    return if row > 2

    return true if @board_array[row][column] == player_color && @board_array[row + 1][column] == player_color &&
                   @board_array[row + 2][column] == player_color && @board_array[row + 3][column] == player_color

    false
  end

  def diagonal_win?(row, column, player_color)
    return if column > 4

    positive_slope?(row, column, player_color) || negative_slope?(row, column, player_color)
  end

  def positive_slope?(row, column, player_color)
    return if row < 3

    return true if @board_array[row][column] == player_color &&
                   @board_array[row - 1][column + 1] == player_color &&
                   @board_array[row - 2][column + 2] == player_color &&
                   @board_array[row - 3][column + 3] == player_color

    false
  end

  def negative_slope?(row, column, player_color)
    return if row > 2

    return true if @board_array[row][column] == player_color &&
                   @board_array[row + 1][column + 1] == player_color &&
                   @board_array[row + 2][column + 2] == player_color &&
                   @board_array[row + 3][column + 3] == player_color

    false
  end
end
