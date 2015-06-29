class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.belongs_to :task
      t.belongs_to :user
      t.timestamps null: false
      t.text :body

    end
  end
end
