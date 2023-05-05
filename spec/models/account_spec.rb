require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do
    it "is not valid without a password" do
      account = Account.new(email: "test@example.com")
      expect(account).not_to be_valid
      expect(account.errors[:password]).to include("can't be blank")
    end

    it "must confirm email" do
      account = Account.new(email: "test@example.com", password: "password")
      account.save
      expect(account.confirmed?).to be(false)

      account.confirm
      expect(account.confirmed?).to be(true)
    end

    it "is valid with valid attributes" do
      account = FactoryBot.build(:account)
      expect(account).to be_valid
    end

    it "is not valid without an email" do
      account = FactoryBot.build(:account, email: nil)
      expect(account).to_not be_valid
    end
  end
end

