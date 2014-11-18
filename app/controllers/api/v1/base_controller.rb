require 'digest'
class Api::V1::BaseController < ApplicationController
  #before_action :check_token
  #respond_to :json

  def check_token
    if params[:secret][-6..-1] == Rails.application.secrets.secret_key_base[15...21]
      require_time = Base64.decode64(Base64.decode64()[0...16])
      require =~ /\-/
      time = $`
      ticket = $'
      if ticket == Rails.application.secrets.secret_key_base[5...14]
        if Time.now - time < 3
          return
        else
          raise TimeOutError
        end
      else
        raise ActionController::InvalidAuthenticityToken
      end
    else
      raise ActionController::InvalidAuthenticityToken
    end
  end

  def set_current_user
    session[:current_user] = (current_user)?(current_user.id):(nil)
  end

  def signed_in?
    !!(session[:current_user])
  end
end
