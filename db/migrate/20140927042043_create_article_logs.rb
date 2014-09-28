class CreateArticleLogs < ActiveRecord::Migration
  def change
    create_table :article_logs do |t|
      t.integer :article_id, null: false
      t.string :title, null: false
      t.text :content

      t.datetime :created_at
    end

    add_index :article_logs,  :article_id
    add_index :article_logs, [:article_id, :created_at], unique: true

  end
end
