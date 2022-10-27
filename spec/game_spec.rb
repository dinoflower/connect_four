# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

    context 'when the space exists, is empty, and is legal' do
      before do
        valid_input = [5, 3]
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display message' do
        message = 'Please enter a row and column.'
        expect(game_input).not_to receive(:puts).with(message)
        game_input.player_input
      end
    end
  end
end

# board[5][3] is the bottom middle space, so it's row, column
