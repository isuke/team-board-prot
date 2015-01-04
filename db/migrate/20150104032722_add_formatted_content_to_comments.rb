class AddFormattedContentToComments < ActiveRecord::Migration
  def up
    add_column :comments, :formatted_content, :text
    set_formatted_content
    change_column :comments, :formatted_content, :text, null: false
  end

  def down
    remove_column :comments, :formatted_content
  end

  def set_formatted_content
    Comment.all.each do |c|
      c.formatted_content = c.content
      c.save!
    end
  end
end
