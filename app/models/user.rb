class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def my_games
    Game.where(:player_id => self.id, :gameover => false)
  end

  def my_challenges
    Game.where(:user_id => self.id, :gameover => false)
  end

  def my_completed_games
    Game.where(:player_id => self.id, :gameover => true)
  end

  def my_completed_challenges
    Game.where(:user_id => self.id, :gameover => true)
  end
end
