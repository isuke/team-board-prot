class AddFormattedContentToArticleLogs < ActiveRecord::Migration
  def up
    add_column :article_logs, :formatted_content, :text
    set_formatted_content
  end

  def down
    remove_column :article_logs, :formatted_content
  end

  def set_formatted_content
    ArticleLog.all.each do |a|
      a.formatted_content = a.content
      a.save!
    end
  end
end
