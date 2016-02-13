class CreateSecureNotes < ActiveRecord::Migration
  def change
    create_table :secure_notes do |t|
      t.belongs_to :wallet, null: false
      t.string :name, null: false
      t.text :note, null: false
      t.timestamps
    end

    add_foreign_key :secure_notes, :wallets
  end
end
