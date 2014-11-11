class AddRoleToTeamsUsers < ActiveRecord::Migration
  def up
    add_column :teams_users, :role, :integer, null: false, default: 30
    TeamsUser.update_all("role = 10") # admin
  end

  def down
    remove_column :teams_users, :role
  end
end
