class Collection < ActiveRecord::Base
  belongs_to :event
  has_many :admissions

  include Redis::Objects
  counter :post_in
  counter :success

  def name_list
    self.admissions.all.map{|a| {ticket: a.ticket_id, name: a.owner_cuc_id}}
  end
end
