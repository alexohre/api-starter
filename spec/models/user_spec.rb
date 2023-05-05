require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without an email" do
    user = User.new(email: nil, password: "password", password_confirmation: "password")
    expect(user).to_not be_valid
  end
  
  it "is not valid without a password" do
    user = User.new(email: "test@example.com", password: nil, password_confirmation: nil)
    expect(user).to_not be_valid
  end
  
  it "is not valid if password and password_confirmation do not match" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "notpassword")
    expect(user).to_not be_valid
  end
  
  it "is not valid if email has already been taken" do
    existing_user = FactoryBot.create(:user, email: "test@example.com")
    new_user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
    expect(new_user).to_not be_valid
  end
  
  it "must confirm email" do
    user = FactoryBot.create(:user)
    user.confirm
    expect(user.confirmed?).to be_truthy
  end
end

