class PostController < ApplicationController
  def show_parent
    @post = Post.find_by(slug: params[:post_slug])
    not_found unless @post.present?

    render plain: @post.inspect
  end
end
