# frozen_string_literal: true

require_relative '../lib/connect_four/board'

describe Board do
  describe '#check_board' do
    subject(:verify_board) { described_class.new }

    context 'when given a legal move' do
      it 'returns the row and column as an array' do
        expect(verify_board.check_board(5, 3)).to match_array([5, 3])
      end
    end

    context 'when given a space above a legal move' do
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

    context 'when given a space above both an occupied space and legal move' do
      before do
        allow(verify_board.board_array).to receive(:dig).with(5, 3).and_return('Y')
      end

      it 'returns nil' do
        expect(verify_board.check_board(3, 3)).to be_nil
      end
    end
  end

  describe '#save_play' do
    subject(:update_board) { described_class.new }

    it 'updates the game board' do
      color = 'Y'
      play = [5, 3]
      update_board.save_play(color, play)
      expect(update_board.board_array[play[0]][play[1]]).to eq('Y')
    end
  end

  describe '#horizontal_win?' do
    subject(:horizontal_board) { described_class.new }

    context 'when there are not four in a row horizontally' do
      it 'returns false' do
        expect(horizontal_board.horizontal_win?(5, 2, 'Y')).to be false
      end
    end

    context 'when there are four in a row horizontally' do
      before do
        horizontal_board.board_array[5][2] = 'Y'
        horizontal_board.board_array[5][3] = 'Y'
        horizontal_board.board_array[5][4] = 'Y'
        horizontal_board.board_array[5][5] = 'Y'
      end

      it 'returns true' do
        expect(horizontal_board.horizontal_win?(5, 2, 'Y')).to be true
      end
    end
  end

  describe '#vertical_win?' do
    subject(:vertical_board) { described_class.new }

    context 'when there are not four in a row vertically' do
      it 'returns false' do
        expect(vertical_board.vertical_win?(2, 3, 'Y')).to be false
      end
    end

    context 'when there are four in a row vertically' do
      before do
        vertical_board.board_array[5][3] = 'Y'
        vertical_board.board_array[4][3] = 'Y'
        vertical_board.board_array[3][3] = 'Y'
        vertical_board.board_array[2][3] = 'Y'
      end

      it 'returns true' do
        expect(vertical_board.vertical_win?(2, 3, 'Y')).to be true
      end
    end
  end

  describe '#positive slope?' do
    subject(:positive_board) { described_class.new }

    context 'when there are not four in a positive slope' do
      it 'returns false' do
        expect(positive_board.positive_slope?(5, 1, 'Y')).to be false
      end
    end

    context 'when there are four in a positive slope' do
      before do
        positive_board.board_array[5][1] = 'Y'
        positive_board.board_array[4][2] = 'Y'
        positive_board.board_array[3][3] = 'Y'
        positive_board.board_array[2][4] = 'Y'
      end

      it 'returns true' do
        expect(positive_board.positive_slope?(5, 1, 'Y')).to be true
      end
    end
  end

  describe '#negative_slope?' do
    subject(:negative_board) { described_class.new }

    context 'when there are not four in a negative slope' do
      it 'returns false' do
        expect(negative_board.negative_slope?(2, 0, 'Y')).to be false
      end
    end

    context 'when there are four in a negative slope' do
      before do
        negative_board.board_array[2][0] = 'Y'
        negative_board.board_array[3][1] = 'Y'
        negative_board.board_array[4][2] = 'Y'
        negative_board.board_array[5][3] = 'Y'
      end

      it 'returns true' do
        expect(negative_board.negative_slope?(2, 0, 'Y')).to be true
      end
    end
  end
end
