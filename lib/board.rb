# frozen_string_literal: true

# Class defining a Connect Four board
class Board
  attr_reader :rack

  def create_rack
    @rack = Array.new(6) { Array.new(7, 0) }
  end

  def insert_token(token, column)
    row = 0
    column -= 1

    return nil unless valid_input?(column)
    return nil if full?(column)

    row += 1 while already_taken?(row, column)

    @rack[row][column] = token
  end

  def valid_input?(column)
    column.between?(0, 6)
  end

  def already_taken?(row, column)
    !@rack[row][column].zero?
  end

  def full?(column)
    !@rack[5][column].zero?
  end

  # rubocop:disable Metrics/MethodLength
  def display_rack
    filled = "\u25cf"
    unfilled = "\u25cb"
    @rack.each do |row|
      row.each do |column|
        print "\e[31m#{filled}\e[0m " if column == 1 # red
        print "\e[32m#{filled}\e[0m " if column == 2 # green
        print "#{unfilled} " if column.zero? # transparent
      end
      puts
    end
    puts '1 2 3 4 5 6 7'
  end
end
# rubocop:enable Metrics/MethodLength

# a = Board.new
# a.create_rack
# a.insert_token(2, 2, 2)
# a.insert_token(1, 3, 3)
# a.display_rack