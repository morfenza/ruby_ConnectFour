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
        expect { board.insert_token(token, column) }.to change { board.rack[0][0] }.from(0).to(1)
      end

      it 'correctly insert a token in a top of another' do
        token = 1
        column = 1
        board.instance_variable_get(:@rack)[0][0] = 1
        expect { board.insert_token(token, column) }.to change { board.rack[1][0] }.from(0).to(1)
      end
    end

    context 'when choosing an already full column' do
      it 'returns nil' do
        token = 1
        column = 1
        i = 0
        loop do
          break if i == 6

          board.instance_variable_get(:@rack)[i][0] = 1
          i += 1
        end
        expect(board.insert_token(token, column)).to be_nil
      end
    end

    context 'when an invalid position is used' do
      it 'returns nil' do
        token = 1
        column = 9
        expect(board.insert_token(token, column)).to be_nil
      end
    end
  end

  describe '#valid_input?' do
    matcher :be_valid do
      match { |column| board.valid_input?(column) }
    end

    context 'when given a valid input' do
      it 'returns true' do
        valid_column = 1
        expect(valid_column).to be_valid
      end
    end

    context 'when given an invalid input' do
      it 'returns false' do
        invalid_column = 8
        expect(invalid_column).to_not be_valid
      end
    end
  end

  describe '#already_taken?' do
    matcher :be_already_taken do
      match { |input| board.already_taken?(input.first, input.last) }
    end

    before do
      board.instance_variable_set(:@rack, (Array.new(6) { Array.new(7, 0) }))
    end

    context 'When there is a token' do
      it 'returns true' do
        valid_row = 0
        valid_column = 0
        board.instance_variable_get(:@rack)[0][0] = 1
        expect([valid_row, valid_column]).to be_already_taken
      end
    end

    context 'When there is not a token' do
      it 'returns false' do
        valid_row = 0
        valid_column = 0
        expect([valid_row, valid_column]).to_not be_already_taken
      end
    end
  end
end
