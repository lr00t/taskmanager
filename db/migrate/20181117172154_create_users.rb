class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :email, null: false, unique: true, index: true
      t.text :password_digest
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
