# frozen_string_literal: true

require_relative 'game'
require_relative 'display'

def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts display_new_game
  repeat_input = gets.chomp.downcase
  if repeat_input == 'yes'
    play_game
  else
    puts display_thanks
    exit
  end
end

play_game
