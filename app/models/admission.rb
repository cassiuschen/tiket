require 'digest'
class Admission < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user

  after_create :generate_token
  before_save :if_ticket_left

  def generate_token
    @user = User.find self.user_id
    self.secret = Digest::MD5.hexdigest(self.id.to_s + @user.cuc_no + Rails.application.secrets.secret_key_base[23...27])
    self.save
  end

  def ticket_id
    @collection = Collection.find collection_id
    @event = Event.find @collection.event_id
    "#{@event.short_name}-#{@collection.id.to_s.rjust(4,'0')}-#{id.to_s.rjust(4, '0')}"
  end

  def owner_cuc_id
    @user = User.find self.user_id
    @user.cuc_no
  end

  def if_ticket_left
    @event = Collection.find(self.collection_id)
    unless @event.admissions.all.size <= @event.maximum
      raise Tiket::NoTicketLeft
    end
  end

  # 此处应该接受Json
  #{
  #    collection_id: '2',
  #    timestamp: "2014-11-13T11:25:56+08:00", #符合ISO8601
  #    user_email: "chzsh1995@gmail.com",
  #    user_cucId: "201408223005",
  #    token: "#{Digest::MD5.hexdigest(timestamp + user_email + user_cucId + Rails.application.secrets.secret_key_base[7...21])}"
  #}
  def self.create_from_params(params)
    @user = User.find_or_create params[:user_email], params[:user_cucId], params[:user_name]
    if Admission.where(user_id: @user.id, collection_id: params[:collection_id].to_i).size >= 1
      raise AlreadyGetOneError
    else
      @admission = Admission.create(
          collection_id: params[:collection_id],
          user_id: @user.id.to_i
      )
      @admission
    end
  end
end
