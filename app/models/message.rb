class Message < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  attr_accessible :text, :type
end
