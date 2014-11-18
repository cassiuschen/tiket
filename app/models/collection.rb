class Collection < ActiveRecord::Base
  belongs_to :event
  has_many :admissions

  include Redis::Objects
  counter :post_in
  counter :success
end
