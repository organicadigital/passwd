class AddRoleOnMembers < ActiveRecord::Migration
  def change
    add_column :members, :role, :string
    execute "update members set role = 'owner'"
    change_column_null :members, :role, false
  end
end
