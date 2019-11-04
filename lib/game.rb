class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
    @normalized_letters = normalized_letters
  end

  def errors
    @user_guesses - @normalized_letters
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def errors_made
    errors.length
  end

  def letters_to_guess
    result = @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      else
        nil
      end
    end
    result
  end

  def over?
    won? || lost?
  end

  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  def normalized_letters
    @letters.map do |letter| 
      normalize_letter(letter) 
    end
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def word
    @normalized_letters.join
  end

  def won?
    (@normalized_letters - @user_guesses).empty?
  end

  def lost?
    errors_allowed == 0
  end
end
