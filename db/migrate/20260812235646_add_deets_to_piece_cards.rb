class AddDeetsToPieceCards < ActiveRecord::Migration[8.1]
  def change
    add_column :piece_cards, :host_symbol, :string, null: false
    add_column :piece_cards, :guest_symbol, :string, null: false
    add_column :piece_cards, :rules, :jsonb, null: false
  end
end
