require 'rails_helper'

RSpec.describe "Deeper::AnotherExamples", type: :request do
  describe "GET /index" do
    it 'is correctly mounted as route' do
      get '/deeper/another_example'
      expect(response).to have_http_status(200)
      expect(response.body).to eq('another example')
    end
  end
end
