# frozen_string_literal: true

require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#create_rack' do
    it 'sets attribute #rack to a nested 6x7 array with default values 0' do
      created_rack = Array.new(6) { Array.new(7, 0) }
      expect { board.create_rack }.to change { board.rack }.from(nil).to(created_rack)
    end
  end

  describe '#insert_token' do
    before do
      board.instance_variable_set(:@rack, (Array.new(6) { Array.new(7, 0) }))
    end

    context 'when a valid position is used' do
      it 'correctly insert a token' do
        token = 1
        column = 1
        row = 1
        expect { board.insert_token(token, row, column) }.to change { board.rack[0][0] }.from(0).to(1)
      end
    end

    context 'when an invalid position is used' do
      it 'returns nil' do
        token = 1
        column = 9
        row = 1
        expect(board.insert_token(token, row, column)).to be_nil
      end
    end

    context 'when there is already a token in the space' do
      it 'returns nil' do
        token = 1
        column = 2
        row = 2
        board.instance_variable_get(:@rack)[1][1] = 1
        expect(board.insert_token(token, row, column)).to be_nil
      end
    end
  end

  describe '#valid_input?' do
    matcher :be_valid do
      match { |input| board.valid_input?(input.first, input.last) }
    end

    context 'when given a valid input' do
      it 'returns true' do
        valid_row = 1
        valid_column = 1
        expect([valid_row, valid_column]).to be_valid
      end
    end

    context 'when given an invalid input' do
      it 'returns false' do
        invalid_row = 9
        invalid_column = 8
        expect([invalid_row, invalid_column]).to_not be_valid
      end
    end
  end
end
