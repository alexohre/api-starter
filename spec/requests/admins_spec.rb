require 'rails_helper'


RSpec.describe "Admins", type: :request do
  describe "GET /admin_details" do
    it "returns http success" do
      # Create a new account using FactoryBot
      admin = FactoryBot.create(:admin)

      # Sign in the account using Devise (assuming that you are using Devise)
      sign_in admin

      # Make the request and check the response status
      get "/admin_details"
      expect(response).to have_http_status(:success)
    end
  end
end
