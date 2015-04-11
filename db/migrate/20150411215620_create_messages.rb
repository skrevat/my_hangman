class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :type
      t.string :text
      t.references :game
      t.references :user

      t.timestamps
    end
    add_index :messages, :game_id
    add_index :messages, :user_id
  end
end
