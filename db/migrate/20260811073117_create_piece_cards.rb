class CreatePieceCards < ActiveRecord::Migration[8.1]
  def change
    create_table :piece_cards do |t|
      t.string :name
      t.integer :level, null: false, default: 1

      t.timestamps
    end
  end
end
