require 'net/http'
module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  def broadcast(channel, &block)
    message = {
        channel: channel,
        data: capture(&block)
    }
    uri = URI.parse "#{Settings.faye_client_url}"
    Net::HTTP.post_form uri, message: message.to_json
  end
end
