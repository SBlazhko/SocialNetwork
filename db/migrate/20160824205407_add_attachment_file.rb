class AddAttachmentFile < ActiveRecord::Migration[5.0]
  def change
    drop_table :attachment_files
    create_table "attachment_files" do |t|
      t.integer :access_level
      t.integer :profile_id
    end
    add_attachment :attachment_files, :file
  end
end
