class AddRankToPieceCards < ActiveRecord::Migration[8.1]
  def change
    add_column :piece_cards, :rank, :integer, null: false, default: 1
  end
end
