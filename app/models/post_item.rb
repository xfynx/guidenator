class PostItem < ApplicationRecord
  belongs_to :parent_post, class_name: 'Post', foreign_key: :parent_post_id
  belongs_to :chapter, class_name: 'Post', foreign_key: :chapter_id, optional: true

  validates :order, presence: true
  validates :chapter_id, uniqueness: true
end
