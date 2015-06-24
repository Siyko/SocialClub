class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: false  do |t|
      t.string :title
      t.text :text
      t.string :task_id, null: false

      t.timestamps null: false

    end
    add_index :tasks,:task_id, unique: true
  end
end
