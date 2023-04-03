# frozen_string_literal: true

require './lib/verify'
require_relative 'messages'
require_relative 'player'
require_relative 'board'

# class defining ConnectFour game logic
class Game
  include Verify
  include Message

  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end

  # rubocop:disable Metrics/MethodLength
  def play_game(player1 = self.player1, player2 = self.player2, board = self.board)
    welcoming_message
    set_names(player1, player2)

    loop do
      board.display_rack
      result = play_round(player1, player2, board)
      if result == 1
        board.display_rack
        display_player_victory(player1.name, player1.token)
        break
      elsif result == 2
        board.display_rack
        display_player_victory(player2.name, player2.token)
        break
      elsif draw?(board)
        board.display_rack
        display_draw_message
        break
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def play_turn(player, board = self.board)
    loop do
      location = board.insert_token(player.token, gets.to_i)

      return game_over?(player.token, board, location[0], location[1]) unless location.nil?

      puts 'Please choose a valid column'
    end
  end

  def play_round(player1 = self.player1, player2 = self.player2, board = self.board)
    display_player_turn(player1.name, player1.token)
    return 1 if play_turn(player1, board) == true

    board.display_rack

    display_player_turn(player2.name, player2.token)
    return 2 if play_turn(player2, board) == true

    board.display_rack
  end

  def set_names(player1 = self.player1, player2 = self.player2)
    ask_name(player1, 1)
    player1.choose_token(1)

    ask_name(player2, 2)
    player2.choose_token(2)
  end

  def ask_name(player, player_num)
    puts "Player ##{player_num}, enter your name: "
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
