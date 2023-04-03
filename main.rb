# frozen_string_literal: true

require './lib/game'

def game_loop
  loop do
    game = Game.new
    game.play_game

    break unless play_again?
  end
end

def play_again?
  puts <<~AGAIN
    # Play another game?
      [1] - Again!
      [2] - Quit
  AGAIN
  ans = gets.chomp.to_i
  ans == 1
end

game_loop
