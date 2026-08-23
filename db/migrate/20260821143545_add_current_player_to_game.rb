class AddCurrentPlayerToGame < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :current_player_id, :integer, null: false
  end
end
