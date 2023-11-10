# frozen_string_literal: true

require 'yaml'
require_relative 'display'

# logic to play the game
class Game
  include Display

  def initialize
    @letter_counter = 0
    @guessed_letter_so_far = []
  end

  def play
    game_set_up
    player_turn
  end

  def game_set_up
    puts display_intro
    read_dictionary_file
    random_word
    puts display_word_length(@word)
  end

  def read_dictionary_file
    filename = File.dirname(Dir.pwd) + '/google-10000-english-no-swears.txt'
    File.exist? filename
    @contents = File.read(filename) if File.exist? filename
  end

  def random_word
    @word = ''
    @word = @contents.split.sample while @word.length < 5 ||
                                         @word.length > 12
    @word_placeholder = ('_ ' * @word.length).strip
    # puts @word
  end

  def player_turn
    puts display_placeholder(@word_placeholder)
    puts display_player_turn
    player_input

    while @guessed_letter_so_far.include?(@guessed_letter)
      puts display_input_duplicate
      player_turn
    end
    conclusion(@guessed_letter)
  end

  def letter_in_word?(guessed_letter)
    @word.include?(guessed_letter)
  end

  def find_indices_of_letters(guessed_letter)
    indices_of_letters = []
    @word.each_char.with_index do |letter, index|
      indices_of_letters.push(index) if guessed_letter == letter
    end
    indices_of_letters
  end

  def player_input
    @guessed_letter = gets.chomp
    if @guessed_letter == 'save'
      game_save
      player_turn
    elsif @guessed_letter == 'load'
      game_load
      player_turn
    else
      @guessed_letter = @guessed_letter.downcase
      until letter_in_word?(@guessed_letter)
        puts display_input_not_in_word
        player_turn
      end
    end
  end

  def replace_letters(word_placeholder, indices_of_letters, guessed_letter)
    indices_of_letters.each do |index|
      word_placeholder[2 * index] = guessed_letter
      @letter_counter += 1
    end
    word_placeholder
  end

  def conclusion(guessed_letter)
    @guessed_letter_so_far.push(guessed_letter)
    indices_of_letters = find_indices_of_letters(guessed_letter)
    @word_placeholder = replace_letters(@word_placeholder, indices_of_letters,
                                        guessed_letter)
    win if @letter_counter == @word.length
    player_turn
  end

  def win
    puts display_placeholder(@word_placeholder)
    puts display_game_won
    repeat_game
  end
end

def game_save
  # filename = "output/savegame_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.txt"

  File.open('savegame.yml', 'w') do |file|
    file.puts YAML.dump(
      'letter_counter' => @letter_counter,
      'guessed_letter_so_far' => @guessed_letter_so_far,
      'word_placeholder' => @word_placeholder,
      'word' => @word
    )
  end
  display_game_saved
end

def game_load
  file = YAML.load_file('savegame.yml')
  @letter_counter = file['letter_counter']
  @guessed_letter_so_far = file['guessed_letter_so_far']
  @word_placeholder = file['word_placeholder']
  @word = file['word']

  puts display_game_loaded
  player_turn
end
