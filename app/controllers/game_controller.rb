class GameController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def create
    game = Game.create(params[:game])
    game.user_id = current_user.id
    game.guesses = ""
    game.wrong_guesses = ""
    game.save
    redirect_to game_path(game.id)
  end

  def show
    @id = params[:id]
    @game = Game.find(params[:id])
    @gameover = @game.gameover || false
    @word = @game.word_with_guesses
    @wrong_guesses = @game.wrong_guesses
    @remaining = 7 - @wrong_guesses.length
  end

  def update
    game = Game.find(params[:id])
    begin
      game.guess(params[:guess])
      check = game.check_win_or_lose
      if check == :win
        flash[:notice] = "You win!"
      elsif check == :lose
        flash[:warning] = "You lose!"
      end
      redirect_to game_path(game.id)
    rescue ArgumentError
      flash[:warning] = "Please enter appropriate guess."
      redirect_to game_path(game.id)
    end
  end

  def give_up
    game = Game.find(params[:id])
    game.gameover = true
    game.save
    flash[:warning] = "You gave up."
    redirect_to game_path(params[:id])
  end
end
