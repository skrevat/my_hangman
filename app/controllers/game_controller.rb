class GameController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def challenge
  end

  def create
    if params[:user]
      user = User.find_by_email(params[:user])
      if !user
        flash[:warning] = "Please enter an existing user."
        return redirect_to challenge_path
      end
    end
    game = Game.create(params[:game])
    game.user_id = current_user.id
    game.guesses = ""
    game.wrong_guesses = ""
    game.gameover = false
    ### Will change to challenged player if player exists
    game.player_id = if user then user.id else current_user.id end
    game.save
    if user
      return redirect_to my_games_path
    else
      return redirect_to game_path(game.id)
    end
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

  def my_games
    @games = current_user.my_games
    @challenges = current_user.my_challenges
    @completed_games = current_user.my_completed_games
    @completed_challenges = current_user.my_completed_challenges
  end
end
