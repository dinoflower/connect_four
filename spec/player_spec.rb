# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#won?' do
    let(:check_board) { instance_double(Board, board_array: Array.new(6) { Array.new(7) }) }
    subject(:check_players) { described_class.new('Kaedi', 'Y', check_board) }

    before do
      allow(check_board).to receive(:check_plays).with('Y')
    end

    it 'sends check_plays to the board' do
      expect(check_board).to receive(:check_plays).once
      check_players.won?
    end
  end
end
