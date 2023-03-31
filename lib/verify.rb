# frozen_string_literal: true

# module with methods for end game scenarios
module Verify
  def game_over?(token, board, row_index, column_index)
    horizontal?(token, board, row_index, column_index) ||
      vertical?(token, board, row_index, column_index) ||
      diagonal?(token, board, row_index, column_index)
  end

  # Checks for horizontal connections on given token
  def horizontal?(token, board, row_index, column_index)
    pivot = column_index + 3
    while column_index >= 0
      if pivot > 6
        column_index, pivot = minus_one(column_index, pivot)
        next
      end

      return true if (board.rack[row_index][column_index..pivot].all? { |el| el == token }) == true

      column_index, pivot = minus_one(column_index, pivot)
    end
  end

  # Checks for vertical connections on given token
  def vertical?(token, board, row_index, column_index)
    return if row_index < 3

    aux_array = []
    pivot = row_index
    below_pivot = row_index - 3

    pivot.downto(below_pivot) { |index| aux_array << board.rack[index][column_index] }

    aux_array.all? { |el| el == token } == true ? true : nil
  end

  # Checks for diagonal connections on given token, for both directions
  def diagonal?(token, board, row_index, column_index)
    left_diagonal?(token, board, row_index, column_index) ||
      right_diagonal?(token, board, row_index, column_index)
  end

  def left_diagonal?(token, board, row_index, column_index)
    aux_array = []

    while row_index.between?(0, 5)
      unless column_index.between?(0, 6)
        column_index, row_index = plus_one(column_index, row_index)
        next
      end

      0.upto(3) { |aux| aux_array << board.rack[row_index - aux][column_index - aux]}

      return true if aux_array.all? { |el| el == token } == true

      aux_array.clear

      column_index, row_index = plus_one(column_index, row_index)
    end
  end

  def right_diagonal?(token, board, row_index, column_index)
    aux_array = []

    while row_index.between?(0, 5)
      unless column_index.between?(0, 6)
        column_index -= 1
        row_index += 1
        next
      end

      0.upto(3) { |aux| aux_array << board.rack[row_index - aux][column_index + aux]}

      return true if aux_array.all? { |el| el == token } == true

      aux_array.clear

      column_index -= 1
      row_index += 1
    end
  end

  def plus_one(first, second)
    [first.succ, second.succ]
  end

  def minus_one(first, second)
    [first.pred, second.pred]
  end
end
