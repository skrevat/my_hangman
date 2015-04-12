class AddGameOverToGames < ActiveRecord::Migration
  def change
    add_column :games, :gameover, :boolean
  end
end
