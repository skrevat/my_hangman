class AddPlayerToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_id, :int
  end
end
