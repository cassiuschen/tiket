# encoding: utf-8
require 'carrierwave/processing/mini_magick'
class ThumbUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/images/thumb_#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [300, 300]
  end

  version :large do
    process :resize_to_fit => [1024, 1024]
  end

  version :xlarge do
    process :resize_to_fit => [1600, 1600]
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def file_id
    "#{model.id}"
  end

  def file_type
    "#{file.extension}"
  end

  def filename
    "#{model.id}.#{file.extension}" if original_filename.present?
  end

  def qiniu_async_ops
      commands = []
      %W(thumb xlarge large).each do |style|
        commands << "http://#{self.qiniu_bucket_domain}/#{self.store_dir}/#{self.file_id}-#{style}.#{self.file_type}"
      end
      commands
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
