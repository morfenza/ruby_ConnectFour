# frozen_string_literal: true

# Class defining a player
class Player
  attr_reader :name, :token

  def give_name(name)
    @name = name if valid?(name)
  end

  def choose_token(token)
    @token = token if token.between?(1, 2)
  end

  def valid?(name)
    name.length.between?(2, 8) && name.chars.all? { |character| character.match?(/[a-zA-Z]/) }
  end
end
