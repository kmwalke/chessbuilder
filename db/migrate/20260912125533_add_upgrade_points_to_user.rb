class AddUpgradePointsToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :upgrade_points, :integer, null: false, default: 0
  end
end
