# frozen_string_literal: true

class Accounts::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  respond_to :json

  def respond_with(resource, options={})
    render json: {
      status: { code: 200, message: "Account signed in successfully",
      data: current_account  }
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_account = Account.find(jwt_payload["sub"])

    if current_account
      render json: {
        status: 200, message: "Signed out successfully"
      }, status: :ok
      else
        render json: {
          status: 401, message: "No active account session"
        }, status: :unauthorized
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
