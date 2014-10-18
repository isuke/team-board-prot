class AddUserIdToArticleLogs < ActiveRecord::Migration
  def up
    add_column :article_logs, :user_id, :integer

    set_user_id

    change_column :article_logs, :user_id, :integer, null: false
  end

  def down
    remove_column :article_logs, :user_id
  end

  def set_user_id
    name  = "first_user"
    email = "first_user@example.com"
    password = "foobar"
    user = User.first_or_create(name: name,
                                email: email,
                                password: password,
                                password_confirmation: password)
    ArticleLog.all.each do |a|
      a.update_attributes!(user_id: user.id)
    end
  end
end
