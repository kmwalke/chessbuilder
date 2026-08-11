class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :motto
      t.integer :level, null: false, default: 0
      t.string :role, null: false, default: User::USER

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
