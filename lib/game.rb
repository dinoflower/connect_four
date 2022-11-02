# frozen_string_literal: true

require_relative 'player'

# game portion of connect four
class Game
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def player_input
    row = gets.chomp
    column = gets.chomp
    legal_move = verify_input(row.to_i, column.to_i) if row.match?(/^\d+$/) && column.match?(/^\d+$/)
    return legal_move if legal_move

    puts 'Input error! Please make a valid play.'
  end

  def verify_input(row, column)
    return unless row.between?(0, 6) && column.between?(0, 7)
    return if board[(row + 1)..].any? { |arr| arr[column].nil? }

    return [row, column] if board.dig(row, column).nil?
  end
end
