# frozen_string_literal: true

# Text needed for Hangman
module Display
  def display_intro
    "\nLet's play Hangman! \n\nType 'save' at any time to save your game.\nType 'load' to load a saved game.\n\n"
  end

  def display_placeholder(word_placeholder)
    puts word_placeholder
  end

  def display_word_length(word)
    "\nThe word consists of #{word.length} letters:\n"
  end

  def display_player_turn
    "\nPlease type in a letter to narrow down the word:\n\n"
  end

  def display_input_duplicate
    "\nLetter was already used. Please, try again.\n"
  end

  def display_input_not_in_word
    "\nLetter is not in the word. Please, try again.\n"
  end

  def display_game_loaded
    "\nGame loaded!\n"
  end

  def display_game_saved
    "\nGame saved!\n"
  end

  def display_game_won
    "\nYou have guessed the word, congratulations!\n"
  end

  def display_new_game
    "\nWould you like to play a new game?\ntype 'yes' or 'no'\n\n"
  end

  def display_thanks
    "\nThanks for playing!\n"
  end
end
