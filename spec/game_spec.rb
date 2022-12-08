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

  describe '#player_input' do
    subject(:game_input) { described_class.new }
    let(:game_board) { double('board') }

    context 'when the space exists, is empty, and is legal' do
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

    context 'when the user inputs a valid but illegal move once and then a legal move' do
      before do
        illegal_row = '4'
        valid_column = '3'
        valid_row = '5'
        allow(game_input).to receive(:gets).and_return(illegal_row, valid_column, valid_row, valid_column)
        allow(game_board).to receive(:check_board).and_return(nil, [valid_row, valid_column])
      end

      it 'completes loop and displays the error message once' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).to receive(:puts).with(message).once
        game_input.player_input
      end
    end
  end

  describe '#update_board' do
    let(:save_board) { instance_double(Board, board_array: Array.new(6) { Array.new(7) }) }
    subject(:update_game) { described_class.new(save_board) }

    before do
      allow(update_game.current_player).to receive(:color).and_return('Y')
      allow(update_game).to receive(:player_input).and_return([5, 3])
    end

    it 'sends the move to the board' do
      expect(save_board).to receive(:save_play).with('Y', [5, 3])
      update_game.update_board
    end
  end
end
