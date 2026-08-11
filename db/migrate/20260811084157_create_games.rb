class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.integer :host_id, null: false
      t.integer :guest_id, null: false

      t.timestamps
    end
  end
end
