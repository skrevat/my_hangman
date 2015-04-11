class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :word
      t.string :guesses
      t.string :wrong_guesses
      t.references :user
      t.references :creator

      t.timestamps
    end
    add_index :games, :user_id
    add_index :games, :creator_id
  end
end
