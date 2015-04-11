class GameController < ApplicationController
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
    @word = @game.word_with_guesses
    @wrong_guesses = @game.wrong_guesses
    @remaining = 7 - @wrong_guesses.length
  end

  def update
    game = Game.find(params[:id])
    game.guess(params[:guess])
    if game.check_win_or_lose
      flash[:notice] = "You win!"
      redirect_to game_path(game.id)
    else
      redirect_to game_path(game.id)
    end
  end
end
