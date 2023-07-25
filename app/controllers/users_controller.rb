class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end
end
