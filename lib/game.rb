# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# game portion of connect four
class Game
  attr_accessor :board_array
  attr_reader :current_player

  def initialize(game_board = Board.new)
    @board = game_board
    @board_array = game_board.board_array
    @players = [create_player('Y'), create_player('R')]
    @current_player = @players.sample
  end

  def create_player(color)
    puts 'Please enter your name:'
    name = gets.chomp.capitalize
    Player.new(name, color, @board)
  end

  def play_game
    intro
    player_turn
    display_board
    puts 'Game over. Thanks for playing!'
  end

  def player_turn
    return if game_over?

    display_board
    puts "#{@current_player.name}, make your move!"
    player_move = player_input
    @board.save_play(@current_player.color, player_move)
    @current_player = swap_players
  end

  def game_over?
    @players[0].won? || @players[1].won?
  end

  def display_board
    print "    0 1 2 3 4 5 6\n"
    print "    _ _ _ _ _ _ _\n"
    @board_array.each_with_index do |row, i|
      print "#{i}: |", row.map { |square| square.nil? ? '_' : square }.join('|'), "|\n"
    end
  end

  def player_input
    loop do
      row = gets.chomp
      column = gets.chomp
      legal_move = verify_input(row.to_i, column.to_i) if row.match?(/^\d+$/) && column.match?(/^\d+$/)
      return legal_move if legal_move

      puts 'Input error! Please make a valid play.'
    end
  end

  def verify_input(row, column)
    return unless row.between?(0, 6) && column.between?(0, 7)

    @board.check_board(row, column)
  end

  def swap_players
    @current_player.color == 'Y' ? @players[1] : @players[0]
  end

  def intro
    puts <<~HEREDOC

      Welcome to Connect Four!

      The first player to match four of their pieces in a row wins.

      Be careful - diagonals count, too!

      #{current_player.name} is going first.

    HEREDOC
  end
end
