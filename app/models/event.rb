class Event < ActiveRecord::Base
  self.primary_key = :short_name
end
