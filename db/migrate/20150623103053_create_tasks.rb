class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks  do |t|
      t.string :title
      t.text :text
      t.string :task_id, null: false

      t.timestamps null: false

    end

  end
end
