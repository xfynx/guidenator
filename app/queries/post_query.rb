class PostQuery
  def initialize(post_slug:, chapter_slug: nil)
    @post_slug = post_slug
    @chapter_slug = chapter_slug
  end

  def parent_post
    @parent_post ||= Post.
      includes(:post_items).
      find_by(slug: @post_slug, published: true)
  end

  def chapter_post
    return if @chapter_slug.blank?

    @chapter_post ||= Post.
      includes(parent_post: [:post_items]).
      find_by(slug: @chapter_slug, parent_post: { slug: @post_slug, published: true }, published: true)
  end
end
