require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is not valid without an email" do
    admin = Admin.new(email: nil)
    expect(admin).to_not be_valid
  end

  it "is not valid without a password" do
    admin = Admin.new(email: "admin@example.com", password: nil)
    expect(admin).to_not be_valid
  end

  it "is valid with an email and password" do
    admin = Admin.new(email: "admin@example.com", password: "password123")
    expect(admin).to be_valid
  end
end
