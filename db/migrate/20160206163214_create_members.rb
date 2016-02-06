class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :wallet, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end

    add_foreign_key :members, :wallets
    add_foreign_key :members, :users
    add_index :members, [:wallet_id, :user_id], unique: true
  end
end
