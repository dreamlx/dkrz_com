class Api::UsersController < Api::BaseController
  def get_info
    @user = current_user
  end
end