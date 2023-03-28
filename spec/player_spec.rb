# frozen_string_literal: true

require './lib/player'

describe Player do
  subject(:player) { described_class.new }

  describe '#give_name' do
    context 'when the names length is between 2 and 8' do
      it 'returns the name' do
        valid_name = 'Ian'
        expect(player.give_name(valid_name)).to eq(valid_name)
      end
    end

    context 'when the names length is too big or too small' do
      it 'returns nil if it is smaller then 2' do
        invalid_name = 'I'
        expect(player.give_name(invalid_name)).to be_nil
      end

      it 'returns nil if it is bigger then 8' do
        invalid_name = 'Ian Mermas Bangui Johnes'
        expect(player.give_name(invalid_name)).to be_nil
      end
    end

    context 'when the name only contain valid characters' do
      it 'returns the name' do
        valid_name = 'Vitu'
        expect(player.give_name(valid_name)).to eq(valid_name)
      end
    end

    context 'when the name contains invalid characters' do
      it 'returns nil' do
        invalid_name = 'Vitu123'
        expect(player.give_name(invalid_name)).to be_nil
      end
    end
  end

  describe '#choose_token' do
    context 'when the game chooses between one of two tokens' do
      it 'correctly sets and return token' do
        token = 1
        chosen_token = player.choose_token(1)
        expect(chosen_token).to eq(token)
      end
    end

    context 'when the game chooses an invalid token' do
      it 'returns nil' do
        chosen_token = player.choose_token(5)
        expect(chosen_token).to be_nil
      end
    end
  end
end
