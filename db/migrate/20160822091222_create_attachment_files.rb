class CreateAttachmentFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_files do |t|
      t.integer :access_level
      t.string :file_type
      t.string :file_name
      t.string :file_url
      t.integer :profile_id
      t.timestamps
    end
  end
end
