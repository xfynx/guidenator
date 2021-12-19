class PostController < ApplicationController
  before_action :init_query_object

  def show_parent
    @post = @query.parent_post
    not_found if @post.blank? || !@post.parent?
    render plain: @post.inspect
  end

  def show_chapter
    @chapter = @query.chapter_post
    not_found if @chapter.blank? || @chapter.parent?
    render plain: @chapter.inspect
  end

  private

  # can be improved: different query objects (for parent and chapter posts) with conditional builders (includes, filter, etc..)
  # for now it's okay to do it simple
  def init_query_object
    @query ||= PostQuery.new(post_slug: params[:post_slug], chapter_slug: params[:chapter_slug])
  end
end
