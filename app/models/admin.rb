class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :reset_password_token, uniqueness: true, if: -> { reset_password_token.present? }

  def jwt_payload
    super
  end

  def set_reset_password_token
    begin
      self.reset_password_token = SecureRandom.random_number(100000..999999).to_s
    end while self.class.exists?(reset_password_token: reset_password_token)
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
  end

  def self.reset_password_by_token(attributes = {})
    admin = find_by(reset_password_token: attributes[:reset_password_token])
    if admin && admin.reset_password_period_valid?
      admin.reset_password(attributes[:password], attributes[:password_confirmation])
    else
      admin = Admin.new
      admin.errors.add(:reset_password_token, :invalid)
    end
    admin
  end

  def self.find_by_reset_password_token(reset_password_token)
    find_by(reset_password_token: reset_password_token)
  end
end
