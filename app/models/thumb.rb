class Thumb < ActiveRecord::Base
  mount_uploader :file, ThumbUploader
end
