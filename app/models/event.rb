class Event < ActiveRecord::Base
  self.primary_key = :short_name
  mount_uploader :cover, CoverUploader

  has_many :collections
end
