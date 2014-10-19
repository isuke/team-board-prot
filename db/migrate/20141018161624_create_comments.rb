class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id, null: false
      t.integer :user_id
      t.text :content, null: false

      t.timestamps
    end

    add_index :comments, :article_id
  end
end
