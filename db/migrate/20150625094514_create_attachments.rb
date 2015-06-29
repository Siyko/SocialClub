class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|

      t.timestamps null: false
      t.string :name
      t.string :attachment_type
      t.references :entity, polymorphic: true, index: true
    end
  end
end
