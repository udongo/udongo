class ContentImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def filename
    @name ||= "#{secure_token}.#{file.extension.downcase}" if original_filename
  end

  private

  def secure_token
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, SecureRandom.hex(4))
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_limit: [800, 600]
end
