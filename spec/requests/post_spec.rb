require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /:post_slug" do
    let(:parent_post) { create(:post, slug: 'some-slug') }

    it 'returns existing post by slug' do
      get "/#{parent_post.slug}"
      expect(response).to have_http_status(200)
    end

    it 'returns 404 if no post found' do
      expect { get '/non-existing-slug' }.to raise_error(ActionController::RoutingError)
    end
  end
end
