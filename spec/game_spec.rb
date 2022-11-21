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

    context 'when the player enters two integers' do
      before do
        int_row = '15'
        int_column = '3'
        allow(game_input).to receive(:gets).and_return(int_row, int_column)
      end

      it 'sends the row and column to the board' do
        game_board = instance_double('Board')
        allow(game_board).to receive(:verify_input)
        expect(game_board).to receive(:verify_input).once
        game_input.player_input
      end
    end

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

    

    context 'when the user inputs an invalid move once, an illegal move once, and then a legal move' do
      before do
        invalid_r = '!'
        invalid_c = 'a'
        illegal_r = '5'
        valid_c = '3'
        valid_r = '4'
        allow(game_input).to receive(:gets).and_return(invalid_r, invalid_c, illegal_r, valid_c, valid_r, valid_c)
      end

      it 'completes loop and displays the error message twice' do
        message = 'Input error! Please make a valid play.'
        expect(game_input).to receive(:puts).with(message).twice
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
