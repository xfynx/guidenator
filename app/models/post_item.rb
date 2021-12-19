class PostItem < ApplicationRecord
  belongs_to :parent_post, class_name: 'Post', foreign_key: :parent_post_id
  belongs_to :chapter, class_name: 'Post', foreign_key: :chapter_id, optional: true

  validates :order, presence: true
  validates :chapter_id, uniqueness: true
  # TODO: validate :chapter_is_not_parent
  # TODO: we should check on save that chapter relation does not have it's own post_items (e.g. it's not parent post)
end
