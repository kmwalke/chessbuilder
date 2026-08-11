class CreateDecksPieceCards < ActiveRecord::Migration[8.1]
  def change
    create_table :decks_piece_cards, id: false do |t|
      t.belongs_to :deck
      t.belongs_to :piece_card
    end
  end
end
