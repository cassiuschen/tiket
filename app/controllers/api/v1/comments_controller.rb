class Api::V1::CommentsController < Api::V1::BaseController
  include Rails.application.routes.url_helpers
  before_action :set_current_user, except: :list
  #before_action :must_be_himself

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {status: 200}
    else
      render json: {status: 503}
    end
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
  def must_be_himself
    unless current_user.id == session[:current_user]
      railse UnauthError
    end
  end

  def comment_params
    params.require(:comment).permit(:user_id, :event_id, :content)
  end
end
