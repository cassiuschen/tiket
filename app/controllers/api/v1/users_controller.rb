class Api::V1::UsersController < Api::V1::BaseController
  def simple_login
    @user = User.where("email = ?", user)
  end

  def check_is_signed_up
    !!(User.where('email = ?', check_params))
  end
  
  def create

    user = User.new(params[:user])
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end


  private
  def check_params
    params[:content]
  end
end
