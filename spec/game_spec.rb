# frozen_string_literal: true

require './lib/game'
require './lib/board'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:cur_player) { double('Ian') }

  describe '#game_over?' do
    context 'when player of a given token connects four tokens' do
      xit 'returns true' do; end
    end

    context 'when player of a given token does not connects four tokens' do
      xit 'returns nil' do; end
    end
  end

  describe '#horizontal?' do
    context 'when there are tokens in a horizontal line' do
      it 'returns true' do
        # setting a horizontal line on a rack
        allow(board).to receive(:rack).and_return(
          [
            [2, 1, 1, 2, 1, 2, 0],
            [1, 1, 1, 1, 2, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 1
        column = 0
        result = game.horizontal?(cur_player.token, board, row, column)

        expect(result).to be true
      end
    end

    context 'when there are not tokens in a horizontal line' do
      it 'returns nil' do
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 1, 2, 0],
            [0, 0, 1, 1, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 0
        column = 1
        result = game.horizontal?(cur_player.token, board, row, column)

        expect(result).to be_nil
      end
    end
  end

  describe '#vertical?' do
    context 'when there are tokens in a vertical line' do
      it 'returns true' do
        # setting a vertical line on a rack
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 2, 2, 2, 2, 0],
            [0, 1, 1, 1, 2, 0, 0],
            [0, 0, 1, 1, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 4
        column = 2
        result = game.vertical?(cur_player.token, board, row, column)

        expect(result).to be true
      end
    end

    context 'when there are not tokens in a vertical line' do
      it 'returns nil' do
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 1, 2, 0],
            [0, 0, 1, 1, 2, 0, 0],
            [0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 2
        column = 4
        result = game.horizontal?(cur_player.token, board, row, column)

        expect(result).to be_nil
      end
    end
  end

  describe '#left_diagonal?' do
    context 'when there are tokens in a diagonal line' do
      it 'returns true' do
        # setting a diagonal line on a rack
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 2, 2, 0],
            [0, 1, 1, 1, 2, 0, 0],
            [0, 0, 1, 1, 2, 0, 0],
            [0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 2
        column = 3
        result = game.left_diagonal?(cur_player.token, board, row, column)

        expect(result).to be true
      end
    end

    context 'when there are not tokens in a diagonal line' do
      it 'returns nil' do
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 1, 2, 0],
            [0, 0, 1, 1, 2, 0, 0],
            [0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(1)

        row = 0
        column = 1
        result = game.left_diagonal?(cur_player.token, board, row, column)

        expect(result).to be_nil
      end
    end
  end

  describe '#right_diagonal?' do
    context 'when there are tokens in a diagonal line' do
      it 'returns true' do
        # setting a diagonal line on a rack
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 2, 2, 0],
            [0, 1, 2, 1, 2, 2, 0],
            [0, 0, 1, 1, 2, 0, 0],
            [0, 0, 1, 2, 1, 0, 0],
            [0, 0, 2, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(2)

        row = 1
        column = 5
        result = game.right_diagonal?(cur_player.token, board, row, column)

        expect(result).to be true
      end
    end

    context 'when there are not tokens in a diagonal line' do
      it 'returns nil' do
        allow(board).to receive(:rack).and_return(
          [
            [0, 1, 1, 2, 1, 2, 0],
            [0, 0, 1, 1, 2, 0, 0],
            [0, 0, 2, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
          ]
        )
        allow(cur_player).to receive(:token).and_return(2)

        row = 2
        column = 2
        result = game.right_diagonal?(cur_player.token, board, row, column)

        expect(result).to be_nil
      end
    end
  end
end
