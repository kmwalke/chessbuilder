class AddPlayerToPiece < ActiveRecord::Migration[8.1]
  def change
    add_column :pieces, :player, :string, null: false
  end
end
