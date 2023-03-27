# frozen_string_literal: true

# Class defining a player
class Player
  attr_reader :name

  def give_name(name)
    @name = name if valid?(name)
  end

  def valid?(name)
    name.length.between?(2, 8) && name.chars.all? { |character| character.match?(/[a-zA-Z]/) }
  end
end
