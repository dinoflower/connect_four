# frozen_string_literal: true

require_relative '../lib/connect_four/game'
require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/board'

describe Game do
  describe '#create_player' do
    subject(:game_player) { described_class.new }

    before do
      name = 'Kaedi'
      allow(game_player).to receive(:gets).and_return(name)
    end

    it 'create a player' do
      board = game_player.instance_variable_get(:@board)
      expect(Player).to receive(:new).with('Kaedi', 'yellow', board)
      game_player.create_player('yellow')
    end
  end

  describe '#play_game' do
    subject(:playing_game) { described_class.new }

    context 'when the game is not over once and then over' do
      before do
        allow(playing_game).to receive(:intro).and_return(nil)
        allow(playing_game).to receive(:player_turn).and_return(nil)
        allow(playing_game).to receive(:display_board).and_return(nil)
        allow(playing_game).to receive(:game_over?).and_return(false, true)
      end

      it 'calls #intro once' do
        expect(playing_game).to receive(:intro).once
        playing_game.play_game
      end

      it 'calls #player_turn twice' do
        expect(playing_game).to receive(:player_turn).twice
        playing_game.play_game
      end

      it 'calls #display_board twice' do
        expect(playing_game).to receive(:display_board).twice
        playing_game.play_game
      end
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }
    let(:game_board) { double('board') }

    context 'when the user inputs valid values' do
      before do
        valid_row = '5'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(valid_row, valid_column)
        allow(game_board).to receive(:check_board).and_return([valid_row, valid_column])
      end

      it 'stops loop and does not display message' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).not_to receive(:puts).with(message)
        game_input.player_input
      end
    end

    context 'when the user inputs non-number values once and then valid values' do
      before do
        invalid_row = '!'
        invalid_column = 'a'
        valid_row = '5'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(invalid_row, invalid_column, valid_row, valid_column)
        allow(game_board).to receive(:check_board).and_return(nil, [valid_row, valid_column])
      end

      it 'completes loop and displays the error message once' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).to receive(:puts).with(message).once
        game_input.player_input
      end
    end
  end

  describe '#player_turn' do
    let(:save_board) { instance_double(Board, board_array: Array.new(6) { Array.new(7) }) }
    subject(:update_game) { described_class.new(save_board) }

    it 'sends the move to the board' do
      current_player = update_game.instance_variable_get(:@current_player)
      allow(current_player).to receive(:color).and_return('Y')
      allow(update_game).to receive(:player_input).and_return([5, 3])
      expect(save_board).to receive(:save_play).with('Y', [5, 3])
      update_game.player_turn
    end
  end

  describe '#swap_players' do
    subject(:swap_game) { described_class.new }

    it "ends the current player's turn" do
      current_player = swap_game.instance_variable_get(:@current_player)
      expect(swap_game.swap_players).not_to eq(current_player)
    end

    it 'does not return nil' do
      expect(swap_game.swap_players).not_to be_nil
    end
  end

  describe '#verify_input' do
    let(:verify_board) { double('board', board_array: Array.new(6) { Array.new(7) }) }
    subject(:verify_game) { described_class.new(verify_board) }

    context 'when given an invalid coordinate pair' do
      before do
        invalid_row = 8
        invalid_column = 3
        allow(verify_board).to receive(:check_board).with(invalid_row, invalid_column)
      end

      it 'does not send #check_board to the board' do
        expect(verify_board).not_to receive(:check_board)
        verify_game.verify_input(8, 3)
      end
    end

    context 'when given a valid coordinate pair' do
      before do
        valid_row = 5
        valid_column = 3
        allow(verify_board).to receive(:check_board).with(valid_row, valid_column)
      end

      it 'sends #check_board to the board' do
        expect(verify_board).to receive(:check_board).with(5, 3)
        verify_game.verify_input(5, 3)
      end
    end
  end

  describe '#game_over?' do
    let(:over_board) { instance_double(Board, board_array: Array.new(6) { Array.new(7) }) }
    subject(:over_game) { described_class.new(over_board) }

    before do
      allow(over_board).to receive(:check_lines).exactly(42).times
      allow(over_board).to receive(:full?)
    end

    it 'sends #won? to the players' do
      players = over_game.instance_variable_get(:@players)
      expect(players[0]).to receive(:won?)
      over_game.game_over?
    end

    context 'when the game is not over' do
      before do
        allow(over_board).to receive(:check_lines).and_return(false)
        allow(over_board).to receive(:full?).and_return(false)
      end

      it 'returns false' do
        expect(over_game.game_over?).to be false
        over_game.game_over?
      end
    end

    context 'when a player has won' do
      it 'returns true' do
        players = over_game.instance_variable_get(:@players)
        allow(players[0]).to receive(:won?).and_return(true)
        allow(over_board).to receive(:full?)
        expect(over_game.game_over?).to be true
        over_game.game_over?
      end
    end
  end

  describe '#winner?' do
    let(:ending_board) { double('board', board_array: Array.new(6) { Array.new(7) }) }
    subject(:ending_game) { described_class.new(ending_board) }

    context 'when a player has won' do
      before do
        allow(ending_board).to receive(:full?).and_return(false)
      end

      it 'declares that player the winner' do
        players = ending_game.instance_variable_get(:@players)
        winning_player = players[0]
        allow(winning_player).to receive(:won?).and_return(true)
        expect(ending_game.winner?).to eq(winning_player)
      end
    end

    context 'when the board is full' do
      before do
        allow(ending_board).to receive(:full?).and_return(true)
      end

      it 'does not declare a winner' do
        expect(ending_game.winner?).to be_nil
      end
    end
  end
end
