class TableOfContentBuilder
  def initialize(parent_post)
    @parent_post = parent_post
  end

  def call
    @parent_post.available.order(:order).map do |post_item|
      if post_item.chapter.present?
        chapter = post_item.chapter
        {
          id: chapter.id,
          name: chapter.title,
          slug: chapter.slug,
          type: :post
        }
      else
        {
          name: post_item.section,
          type: :section
        }
      end
    end
  end
end
