# frozen_string_literal: true

require './lib/game'
require './lib/board'
require './lib/player'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:cur_player) { double('Ian') }

  describe '#initialize' do
    it 'creates board object' do
      expect(Board).to receive(:new)
      Game.new
    end

    it 'creates player objects' do
      expect(Player).to receive(:new).twice
      Game.new
    end
  end

  describe '#play_turn' do
    let(:player1) { instance_double(Player, token: 1) }

    context 'when one turn is played' do
      context 'when token is inserted for a given player' do
        before do
          available_row = 1
          chosen_column = 1
          allow(game).to receive(:game_over?).with(player1.token, board, available_row, chosen_column)
        end

        context 'when given valid column' do
          before do
            allow(game).to receive(:gets).and_return(1)
            allow(board).to receive(:insert_token).with(player1.token, 1).and_return([1, 1])
          end

          it 'inserts token' do
            expect(board).to receive(:insert_token).with(player1.token, 1).and_return([1, 1])
            game.play_turn(player1, board)
          end

          it 'checks for victory' do
            expect(game).to receive(:game_over?).with(player1.token, board, 1, 1)
            game.play_turn(player1, board)
          end
        end

        context 'when given invalid column' do
          before do
            allow(game).to receive(:gets).and_return(89, 1)
            allow(board).to receive(:insert_token).and_return(nil, [1, 1])
          end

          it 'puts error message once' do
            error_message = 'Please choose a valid column'
            expect(game).to receive(:puts).with(error_message).once
            game.play_turn(player1, board)
          end
        end
      end
    end
  end

  describe '#set_names' do
    let(:player1) { instance_double(Player) }
    let(:player2) { instance_double(Player) }

    before do
      allow(player1).to receive(:choose_token)
      allow(player2).to receive(:choose_token)
      allow(game).to receive(:ask_name).twice
    end

    it 'sets token for both players' do
      expect(player1).to receive(:choose_token).with(1)
      expect(player2).to receive(:choose_token).with(2)
      game.set_names(player1, player2)
    end
  end

  describe '#ask_name' do
    let(:player1) { instance_double(Player) }

    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets)
    end

    context 'when given valid input' do
      it 'returns the input' do
        result = 'Inha'
        player_token = 1
        allow(player1).to receive(:give_name).and_return('Inha')
        expect(game.ask_name(player1, player_token)).to eq(result)
      end
    end

    context 'when given invalid input' do
      it 'puts error message once' do
        player_token = 1
        error_message = 'Invalid name, please input a valid one'
        allow(player1).to receive(:give_name).and_return(nil, 'Inha')
        expect(game).to receive(:puts).with(error_message).once
        game.ask_name(player1, player_token)
      end
    end
  end

  describe '#draw' do
    context 'when given a full board' do
      let(:full_board) { instance_double(Board) }

      it 'returns true' do
        allow(full_board).to receive(:rack).and_return(
          [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [2, 1, 2, 1, 2, 1, 2],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]
          ]
        )
        expect(game.draw?(full_board)).to be true
      end
    end

    context 'when given a non-full board' do
      it 'returns nil' do
        allow(board).to receive(:rack).and_return(Array.new(6) { Array.new(7, 0) })
        expect(game.draw?(board)).to be_nil
      end
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
