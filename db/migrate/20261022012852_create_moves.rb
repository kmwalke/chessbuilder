class CreateMoves < ActiveRecord::Migration[8.1]
  def change
    create_table :moves do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :a1_notation, null: false

      t.timestamps
    end
  end
end
