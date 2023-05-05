class AccountsController < ApplicationController
  before_action :authenticate_account!
  def index
    render json:  current_account, status: :ok
  end
end
