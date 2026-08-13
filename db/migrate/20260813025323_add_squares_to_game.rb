class AddSquaresToGame < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :squares, :jsonb
  end
end
