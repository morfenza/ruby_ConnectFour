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

  def play_turn(player, board = self.board)
    loop do
      location = board.insert_token(player.token, gets.to_i)

      return game_over?(player.token, board, location[0], location[1]) unless location.nil?

      puts 'Please choose a valid column'
    end
  end

  def set_names(player1 = self.player1, player2 = self.player2)
    ask_name(player1, 1)
    player1.choose_token(1)

    ask_name(player2, 2)
    player2.choose_token(2)
  end

  def ask_name(player, player_num)
    puts "Player #1#{player_num}, enter your name: "
    loop do
      input = gets
      input ||= ''
      input = input.chomp
      name = player.give_name(input)

      return name unless name.nil?

      puts 'Invalid name, please input a valid one'
    end
  end
end
