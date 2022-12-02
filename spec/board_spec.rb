# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#check_board' do
    subject(:verify_board) { described_class.new }

    context 'when given an empty space on the board' do
      it 'returns the row and column as an array' do
        expect(verify_board.check_board(5, 3)).to match_array([5, 3])
      end
    end

    context 'when given a space that is too high' do
      it 'returns nil' do
        expect(verify_board.check_board(4, 3)).to be_nil
      end
    end

    context 'when given an occupied space' do
      before do
        allow(verify_board.board_array).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'returns nil' do
        expect(verify_board.check_board(5, 3)).to be_nil
      end
    end

    context 'when given a high space over an occupied space' do
      before do
        allow(verify_board.board_array).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'returns nil' do
        expect(verify_board.check_board(3, 3)).to be_nil
      end
    end
  end
end
