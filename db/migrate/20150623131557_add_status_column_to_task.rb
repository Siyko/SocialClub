class AddStatusColumnToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :task_status, index: true, foreign_key: true
  end
end
