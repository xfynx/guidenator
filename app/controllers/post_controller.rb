class PostController < ApplicationController
  def show_parent
    @post = Post.
      includes(:post_items).
      find_by(slug: params[:post_slug], published: true)

    not_found if @post.blank? || !@post.parent?

    render plain: @post.inspect
  end

  def show_chapter
    @chapter = Post.
      includes(parent_post: [:post_items]).
      find_by(slug: params[:chapter_slug], parent_post: { slug: params[:post_slug], published: true }, published: true)

    not_found if @chapter.blank? || @chapter.parent?

    render plain: @chapter.inspect
  end
end
