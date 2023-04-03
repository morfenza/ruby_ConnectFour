# frozen_string_literal: true

# Module defining the game messages to be displayed
module Message
  def welcoming_message
    puts <<~MENU
      Welcome!

      This is Connect Four, connect four tokens
      in any direction to win!

      This is a PvP game, bring a friend!
      Let's play!!
    MENU
  end

  def display_player_turn(name, token)
    cell = "\u25cf"
    color = token == 1 ? "\e[31m#{cell}\e[0m" : "\e[32m#{cell}\e[0m "
    puts "#{color} #{name}'s turn, please enter a column number: "
  end

  def display_player_victory(name, token)
    colored_name = token == 1 ? "\e[31m#{name}\e[0m" : "\e[32m#{name}\e[0m "
    puts "#{colored_name} won! Congratulations!"
  end

  def display_draw_message
    puts "It's a draw, no one wins!"
  end

  def display_play_again
    puts <<~AGAIN
      # Play another game?
        [1] - Again!
        [2] - Quit
    AGAIN
  end
end
