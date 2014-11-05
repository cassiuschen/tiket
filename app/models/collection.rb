class Collection < ActiveRecord::Base
  belongs_to :event
  has_many :admissions
end
