class AddCheckToGame < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :check, :boolean, null: false, default: false
  end
end
