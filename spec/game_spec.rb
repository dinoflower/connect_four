# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

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

    before do
      allow(update_game.current_player).to receive(:color).and_return('Y')
      allow(update_game).to receive(:player_input).and_return([5, 3])
    end

    it 'sends the move to the board' do
      expect(save_board).to receive(:save_play).with('Y', [5, 3])
      update_game.player_turn
    end
  end

  describe '#swap_players' do
    subject(:swap_game) { described_class.new }

    it "ends the current player's turn" do
      current_player = swap_game.current_player
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
    end

    it 'sends #won? to the players' do
      players = over_game.instance_variable_get(:@players)
      expect(players[0]).to receive(:won?)
      over_game.game_over?
    end

    context 'when no player has won' do
      before do
        allow(over_board).to receive(:check_lines).and_return(false)
      end

      it 'returns false' do
        expect(over_game.game_over?).to be false
      end
    end
  end
end
