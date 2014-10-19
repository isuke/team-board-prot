class AddUserIdToArticleLogs < ActiveRecord::Migration
  def up
    add_column :article_logs, :user_id, :integer
  end

  def down
    remove_column :article_logs, :user_id
  end
end
