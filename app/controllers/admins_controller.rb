class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    render json:  current_admin, status: :ok
  end
end
