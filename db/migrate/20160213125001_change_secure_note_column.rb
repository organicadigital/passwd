class ChangeSecureNoteColumn < ActiveRecord::Migration
  def change
    rename_column :secure_notes, :note, :encrypted_note
  end
end
