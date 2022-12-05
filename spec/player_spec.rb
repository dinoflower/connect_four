# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#won?' do
    subject(:check_players) { described_class.new('Kaedi', 'Y') }
    let(:check_board) { instance_double(Board, board_array: Array.new(6) { Array.new(7) }) }

    before do
      allow(check_board).to receive(:check_plays).with('Y')
    end

    it 'declares a winner' do
      expect(check_board).to receive(:check_plays).once
      check_players.won?
    end
  end
end
