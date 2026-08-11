class CreatePieceCards < ActiveRecord::Migration[8.1]
  def change
    create_table :piece_cards do |t|
      t.string :name, null: false
      t.integer :level, null: false, default: 0

      t.timestamps
    end
    add_index :piece_cards, :name, unique: true
  end
end
