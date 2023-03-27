# frozen_string_literal: true

# Class defining a Connect Four board
class Board
  attr_reader :rack

  def create_rack
    @rack = Array.new(6) { Array.new(7, 0) }
  end

  def insert_token(token, row, column)
    row -= 1
    column -= 1

    return nil unless valid_input?(row, column)
    return nil if already_taken?(row, column)

    @rack[row][column] = token
  end

  def valid_input?(row, column)
    row.between?(0, 5) && column.between?(0, 6)
  end

  def already_taken?(row, column)
    !@rack[row][column].zero?
  end
end
