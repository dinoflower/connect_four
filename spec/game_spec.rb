# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }
    let(:verify_board) { game_input.board }

    context 'when the space exists, is empty, and is legal' do
      before do
        valid_row = '5'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(valid_row, valid_column)
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
      end

      it 'completes loop and displays the error message once' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).to receive(:puts).with(message).once
        game_input.player_input
      end
    end

    context 'when the user inputs a valid but illegal move once and then a legal move' do
      before do
        invalid_row = '5'
        valid_column = '3'
        valid_row = '4'
        allow(game_input).to receive(:gets).and_return(invalid_row, valid_column, valid_row, valid_column)
        allow(verify_board).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'completes loop and displays the error message once' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).to receive(:puts).with(message).once
        game_input.player_input
      end
    end
  end

  describe '#verify_input' do
    subject(:verify_game) { described_class.new }
    let(:verify_board) { verify_game.board }

    context 'when given an empty space on the board' do
      it 'returns the row and column as an array' do
        expect(verify_game.verify_input(5, 3)).to match_array([5, 3])
      end
    end

    context 'when given a space off of the board' do
      it 'returns nil' do
        expect(verify_game.verify_input(8, 3)).to be_nil
      end
    end

    context 'when given a space that is too high' do
      it 'returns nil' do
        expect(verify_game.verify_input(4, 3)).to be_nil
      end
    end

    context 'when given an occupied space' do
      before do
        allow(verify_board).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'returns nil' do
        expect(verify_game.verify_input(5, 3)).to be_nil
      end
    end

    context 'when given a high space over an occupied space' do
      before do
        allow(verify_board).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'returns nil' do
        expect(verify_game.verify_input(3, 3)).to be_nil
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
    end
  end
end
