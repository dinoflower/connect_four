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
      expect(Player).to receive(:new).with('Kaedi', 'yellow')
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
        invalid_row = '4'
        valid_column = '3'
        valid_row = '5'
        allow(game_input).to receive(:gets).and_return(invalid_row, valid_column, valid_row, valid_column)
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
    subject(:update_game) { described_class.new }

    before do
      move_coord = [5, 3]
      allow(update_game).to receive(:player_input).and_return(move_coord)
      allow(update_game).to receive(:update_play).with(move_coord)
    end

    it 'gets the move from the player' do
      expect(update_game).to receive(:update_play).with([5, 3])
      update_game.update_board
    end
  end

  describe '#update_play' do
    subject(:update_game) { described_class.new }

    it 'updates the game board' do
      expect(update_game.update_play([5, 3])).to include('Y')
      update_game.update_play([5, 3])
    end
  end

  # describe '#check_winners' do
    # subject(:check_game) { described_class.new }
    # let(:check_board) { check_game.board }

    # context 'when a player has four in a row' do
      # before do
        # move_coord = [2, 3]
      # end

      # it 'declares a winner' do
        # expect(check_game.check_winners([2, 3])).to eq('Y')
      # end
    # end
  # end
end
