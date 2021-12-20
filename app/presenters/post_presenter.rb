class PostPresenter
  def initialize(parent_post:, chapter_post: nil)
    @parent_post = parent_post
    @chapter_post = chapter_post
  end

  def call
    post_to_present = @chapter_post.present? ? @chapter_post : @parent_post
    {
      parent_title: @parent_post.title,
      title: post_to_present.title,
      body: post_to_present.body,
      toc: toc
    }
  end

  private

  def toc
    @toc ||= TableOfContentBuilder.new(@parent_post).call
  end
end
