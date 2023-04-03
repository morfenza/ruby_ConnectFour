# frozen_string_literal: true

require './lib/verify'
require_relative 'messages'
require_relative 'player'
require_relative 'board'

# class defining ConnectFour game logic
class Game
  include Verify
  include Message

  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end

  def set_names(player1, player2)
    ask_name(player1, 1)
    player1.choose_token(1)

    ask_name(player2, 2)
    player2.choose_token(2)
  end

  def ask_name(player, player_num)
    puts "Player #1#{player_num}, enter your name: "
    loop do
      name = player.give_name(gets.chomp)

      return name unless name.nil?

      puts 'Invalid name, please input a valid one'
    end
  end
end
