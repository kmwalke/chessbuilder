class CreatePieces < ActiveRecord::Migration[8.1]
  def change
    create_table :pieces do |t|
      t.integer :piece_card_id
    end
  end
end
