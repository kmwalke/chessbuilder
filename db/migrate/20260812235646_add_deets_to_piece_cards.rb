class AddDeetsToPieceCards < ActiveRecord::Migration[8.1]
  def change
    add_column :piece_cards, :host_symbol, :string
    add_column :piece_cards, :guest_symbol, :string
  end
end
