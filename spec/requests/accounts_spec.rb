require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /account_details" do
    it "returns http success" do
      account = FactoryBot.create(:account, confirmed_at: Time.now)
      sign_in account
      get account_details_path, params: { options: { host: 'localhost:3000' } }
      expect(response).to have_http_status(:success)
    end
  end
end



