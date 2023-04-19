class UsersController < ApplicationController
  def index
    render json: User.all, status: 200
  end
end
