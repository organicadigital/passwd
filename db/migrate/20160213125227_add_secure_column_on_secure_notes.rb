class AddSecureColumnOnSecureNotes < ActiveRecord::Migration
  def change
    add_column :secure_notes, :encrypted_note_salt, :text
    add_column :secure_notes, :encrypted_note_iv, :text
  end
end
