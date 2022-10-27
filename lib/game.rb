# frozen_string_literal: true

require_relative 'player'

# game portion of connect four
class Game
  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def player_input
    row = gets.chomp
    column = gets.chomp
    legal_move = verify_input([row.to_i, column.to_i]) if row.match?(/^\d+$/) && column.to_i.match?(/^\d+$/)
    return legal_move if legal_move

    puts 'Input error! Please make a valid play.'
  end
end
