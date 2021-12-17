require 'rails_helper'

RSpec.describe "Examples", type: :request do
  describe "GET /index" do
    it 'is correctly mounted as route' do
      get '/example'
      expect(response).to have_http_status(200)
      expect(response.body).to eq('example')
    end
  end
end
