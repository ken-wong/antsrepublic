require 'rails_helper'

RSpec.describe "queens" do
  describe "GET #search" do
    it "get the search result" do
      queen = create(:user)
      queen.add_role(:queen)
      get "/api/queens/search", {q: queen.name}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["queens"].first
      expect(json["id"]).to eq queen.id
      expect(json["avatar_small_url"]).to eq queen.avatar.small_url
      expect(json["name"]).to eq queen.name
    end
  end
end