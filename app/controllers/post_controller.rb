class PostController < ApplicationController
  def show_parent
    @post = query_object.parent_post
    not_found if @post.blank? || !@post.parent?

    format_respond
  end

  def show_chapter
    @chapter = query_object.chapter_post
    not_found if @chapter.blank? || @chapter.parent?
    @post = @chapter.parent_post

    format_respond
  end

  private

  def format_respond
    @result = presenter.call
    @title = @result[:title]
    respond_to do |format|
      format.json { render json: @result }
      format.html { render template: 'post/show' }
    end
  end

  # can be improved: different query objects (for parent and chapter posts) with conditional builders (includes, filter, etc..)
  # for now it's okay to do it simple
  def query_object
    @query ||= PostQuery.new(post_slug: params[:post_slug], chapter_slug: params[:chapter_slug])
  end

  def presenter
    @presenter ||= PostPresenter.new(parent_post: @post, chapter_post: @chapter)
  end
end
