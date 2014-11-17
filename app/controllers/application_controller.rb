class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.:exception
  protect_from_forgery with: :null_session, except: :api

  private
  def api
    !!(controller_name =~ /api/)
  end
end
