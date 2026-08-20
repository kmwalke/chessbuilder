class AddGameIdToPiece < ActiveRecord::Migration[8.1]
  def change
    add_column :pieces, :game_id, :integer, null: false
    add_column :pieces, :position, :string, null: false

    add_index :pieces, [:game_id, :position], unique: true
  end
end
