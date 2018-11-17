class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :name, null: false
      t.text :description
      t.text :state
      t.text :file
      t.references :user, index: true

      t.timestamps
    end
  end
end
