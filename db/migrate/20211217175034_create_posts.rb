class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.boolean :published, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
