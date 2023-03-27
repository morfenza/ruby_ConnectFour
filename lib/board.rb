# frozen_string_literal: true

# Class defining a Connect Four board
class Board
  attr_reader :rack

  def create_rack
    @rack = Array.new(6) { Array.new(7, 0) }
  end
end
