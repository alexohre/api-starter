require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user_details" do
    it "returns http success" do
      user = FactoryBot.create(:user, confirmed_at: Time.now)
      sign_in user
      get user_details_path, params: { options: { host: 'localhost:3000' } }
      expect(response).to have_http_status(:success)
    end
  end
end
