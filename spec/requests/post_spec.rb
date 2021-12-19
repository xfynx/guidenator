require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /:post_slug" do
    let(:published) { true }
    let(:parent_post) do
      create(:post, published: published).tap { |post| post.post_items.create(section: '123', order: 1) }
    end

    it 'returns existing post by slug' do
      get "/#{parent_post.slug}"
      expect(response).to have_http_status(200)
    end

    it 'returns 404 if no post found' do
      expect { get '/non-existing-slug' }.to raise_error(ActionController::RoutingError)
    end

    context 'post not published' do
      let(:published) { false }

      it 'returns 404' do
        expect { get "/#{parent_post.slug}" }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'post is not parent one' do
      let(:parent_post) { create(:post, slug: 'some-slug', published: published) }

      it 'returns 404' do
        expect { get "/#{parent_post.slug}" }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET /:post_slug/chapter_slug" do
    let(:published_parent) { true }
    let(:published_chapter) { true }
    let(:chapter) { create(:post, published: published_chapter) }
    let(:parent) do
      create(:post, published: published_parent).tap { |post| post.post_items.create(chapter: chapter, order: 1) }
    end

    it 'returns chapter post' do
      get "/#{parent.slug}/#{chapter.slug}"
      expect(response).to have_http_status(200)
    end

    context 'not published chapter' do
      let(:published_chapter) { false }

      it 'returns 404' do
        expect { get "/#{parent.slug}/#{chapter.slug}" }.to raise_error(ActionController::RoutingError)
      end
    end

    it 'returns 404 if different parent slug passed' do
      expect { get "/not-a-parent-slug/#{chapter.slug}" }.to raise_error(ActionController::RoutingError)
    end

    context 'parent post is not published' do
      let(:published_parent) { false }

      it 'returns 404' do
        expect { get "/#{parent.slug}/#{chapter.slug}" }.to raise_error(ActionController::RoutingError)
      end
    end

    it 'returns 404 if no chapter post found' do
      expect { get "/#{parent.slug}/non-existing-chapter" }.to raise_error(ActionController::RoutingError)
    end
  end
end
