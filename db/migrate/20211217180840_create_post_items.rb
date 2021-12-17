class CreatePostItems < ActiveRecord::Migration[7.0]
  def change
    create_table :post_items do |t|
      t.bigint :parent_post_id
      t.bigint :chapter_id
      t.string :section
      t.integer :order, null: false

      t.timestamps
    end

    add_index :post_items, [:parent_post_id, :chapter_id]
  end
end
