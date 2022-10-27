# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

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
        allow(game_input.board).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'completes loop and displays the error message once' do
        message = 'Input error! Please make a valid play'
        expect(game_input).to receive(:puts).with(message).once
        game_input.player_input
      end
    end
  end
end
