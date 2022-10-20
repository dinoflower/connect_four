# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#check_board' do
    context 'when a player has four in a row' do
      subject(:won_game) { described_class.new }
      let(:winning_player) { double('player', symbol: 'R') }
      before do
      end
      it 'declares that player the winner' do
        expect(won_game.check_board(winning_player)).to_return(true)
      end
    end
  end
end

# LINES = ? - no wait we're fancy now it can be a graph
# maybe each "play" is a node that knows what's adjacent?
# the player has to know what's open and what's adjacent if we want a comp. player

# board = Array.new(6) { Array.new(7) }
# each space on the board is a pair - e.g. bottom middle is board[5][3]
# so (x, y) -> board[y - 1][x - 1]
# player (symbol) makes a play (x, y), which saves that info
# when a player makes a move, check the board to see if most recent play
# (new root) makes a win
# new root treated as parent node, test valid connections from there
# [0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]
# nope, even simpler: test ranges
# e.g. four continuous along the x-axis: (assuming [0, 0] for math)
# [0, -3] to [0, 3] ([[0, -3], [0, -2], [0, -1], etc.])
# y-axis: [-3, 0] to [3, 0] ([[-3, 0], [-2, 0], [-1, 0], etc.])
# ascending: [-3, -3] to [3, 3] ([[-3, -3], [-2, -2], [-1, -1], etc.])
# descending: [3, -3] to [-3, 3] ([[3, -3], [2, -2], [1, -1], etc.])
