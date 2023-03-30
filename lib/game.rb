# frozen_string_literal: true

require 'pry-byebug'

# class defining ConnectFour game logic
class Game
  def game_over?(cur_player, board)
    return false if board.rack[0].sum.zero?

    board.rack.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next unless column == cur_player.token

        return true if connection?(cur_player.token, board, row_index, column_index)
      end
    end
  end

  def connection?(token, board, row_index, column_index)
    horizontal?(token, board, row_index, column_index) ||
      vertical?(token, board, row_index, column_index) ||
      diagonal?(token, board, row_index, column_index)
  end

  def horizontal?(token, board, row_index, column_index)
    left = column_index
    right = column_index + 3
    while left >= 0
      if right > 6
        left -= 1
        right -= 1
        next
      end

      return true if (board.rack[row_index][left..right].all? { |el| el == token }) == true

      left -= 1
      right -= 1
    end
  end

  def vertical?(token, board, row_index, column_index)
    return if row_index < 3

    aux_array = []
    pivot = row_index
    below_pivot = row_index - 3

    pivot.downto(below_pivot) { |index| aux_array << board.rack[index][column_index] }

    aux_array.all? { |el| el == token } == true ? true : nil
  end

  def diagonal?(token, board, row_index, column_index); end
end

# PSEUDOCODE
# for each row
# for each column
# checks if there is a token
# if there is:
# returns true if there is a hor, ver or diag line of four
# if there is not:
# next

# returns false
