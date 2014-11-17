class Api::V1::AdmissionsController < Api::V1::BaseController
  include Rails.application.routes.url_helpers
  before_action :set_current_user, except: :list
  #before_action :must_be_himself
  around_action :return_bad_data

  def create
  # WARNING!!!暂不使用token进行加密! --- cassiuschen. 14.11.17
   #if !(is_correct? create_params)
     @admission = Admission.create_from_params create_params
     render json: {admission: @admission.id, user: @admission.user_id}
   #else
   #  render json: {status: 503}
   #end
  end



  def list
    @event = Event.where(short_name: params[:event]).first
    if @event && @event.comments
      render json: @event.comments.map {|c| c.to_json}
    else
      render json: []
    end
  end

  private
  def return_bad_data
    begin
      yield
        puts "#{controller_name}"
    rescue
      render json: {status: 503}
    end
  end

  def success_json(data)
    {
        status: 200,
        content: {
            admission: 057,
            cucId: "201408223005"
        },
        token: "#{Digest::MD5.hexdigest(admission + cucId + Rails.application.secrets.secret_key_base[23...27])}"
    }

  end

  def is_correct?(params)
    !!(params[:token] == Digest::MD5.hexdigest(params[:timestamp] + params[:user_email] + params[:user_cucId] + Rails.application.secrets.secret_key_base[7...21]))
  end

  def create_params
    params
  end
end
