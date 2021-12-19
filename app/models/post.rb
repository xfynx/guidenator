class Post < ApplicationRecord
  has_many :post_items, -> { includes(:chapter) }, foreign_key: :parent_post_id
  has_many :chapters, through: :post_items, source: :chapter
  has_one :post_item, foreign_key: :chapter_id
  has_one :parent_post, through: :post_item, source: :parent_post

  before_validation :set_slug

  validates :title, :slug, uniqueness: true, presence: true
  validates :body, presence: true
  validate :check_path_collision

  def sections
    post_items.where(chapter: nil)
  end

  def available
    sections.or(post_items.where(chapter: {published: true}))
  end

  # if we have at least one content item (section or chapter) - it's parent post obviously
  def parent?
    post_items.present?
  end

  private

  # can be improved: if there is collision with existing slug, we can add some random part to it and save
  def set_slug
    return if title.blank?

    self.slug = (slug.present? ? slug : title).parameterize
  end

  # should be improved: we need to check only root paths. for instance, path like 'deeper/another_example'
  # will be collision for slug like 'deeper_another_example'
  def check_path_collision
    return if slug.blank?

    errors.add(:base, 'Path collision error') if Rails.application.routes.named_routes.get(slug)
  end
end
