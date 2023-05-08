class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable, :confirmable, :jwt_authenticatable, jwt_revocation_strategy: self


  attr_reader :token

  before_validation :generate_confirmation_token, on: :create

  validates :reset_password_token, uniqueness: true, if: -> { reset_password_token.present? }

  def generate_confirmation_token
    if self.confirmation_token.blank? || self.confirmed_at.blank?
      @token = SecureRandom.random_number(100000..999999).to_s
      self.confirmation_token = @token
      self.confirmation_sent_at = Time.now.utc
    end
  end

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
    user = find_by(reset_password_token: attributes[:reset_password_token])
    if user && user.reset_password_period_valid?
      user.reset_password(attributes[:password], attributes[:password_confirmation])
    else
      user = User.new
      user.errors.add(:reset_password_token, :invalid)
    end
    user
  end

  def self.find_by_reset_password_token(reset_password_token)
    find_by(reset_password_token: reset_password_token)
  end
end
