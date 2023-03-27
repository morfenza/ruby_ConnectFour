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
end