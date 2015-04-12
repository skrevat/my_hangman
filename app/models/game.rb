class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :creator
  attr_accessible :guesses, :word, :wrong_guesses, :user_id, :gameover

  def guess(letter)
    error_check(letter)
    if false_guess(letter)
      raise ArgumentError
    end
    if word.include? letter
      self.guesses+=letter.downcase
    else
      self.wrong_guesses+=letter.downcase
    end
    self.save
    return true
  end

  def word_with_guesses()
    w = word
    if self.gameover
      return w
    end
    w.split("").each do |letter|
      if !(guesses.include? letter) && !(guesses.upcase.include? letter) && !(" \n\"\.\,\'\-\?\!".include? letter)
        w = w.gsub(letter, "-")
      end
    end
    return w
  end

  def check_win_or_lose()
    if wrong_guesses.length == 7
      self.gameover = true
      return :lose
    elsif word_with_guesses == word
      self.gameover = true
      self.save
      return :win
    else
      return :play
    end
  end
  def false_guess(letter)
    if (guesses.include? letter.downcase) || (wrong_guesses.include? letter.downcase)
      return true
    end
  end

  def error_check(letter)
    if letter == nil || letter =~ /[^a-zA-Z]/ || letter == ''
	raise ArgumentError
    end
  end

end
