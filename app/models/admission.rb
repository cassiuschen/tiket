require 'digest'
class Admission < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user

  after_create :generate_token
  before_save :if_ticket_left

  def generate_token
    self.secret = Digest::MD5.hexdigest(id + User.find(user_id).cuc_no + Rails.application.secrets.secret_key_base[23...27])
    self.save
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
  #    user: {
  #        email: "chzsh1995@gmail.com",
  #        cucId: "201408223005"
  #    },
  #    token: "#{Digest::MD5.hexdigest(timestamp + user[:email] + user[:cucId] + Rails.application.secrets.secret_key_base[7...21])}"
  #}
  def self.create_from_params(params)
    @user = User.find_or_create params[:user]
    @admission = Admission.create(
                             collection_id: params[:collection_id],
                             user_id: @user.id.to_i
    )
    @admission
  end
end
