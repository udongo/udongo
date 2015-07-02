class ContentImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def filename
    @name ||= "#{secure_token}-#{model.id}.#{file.extension.downcase}" if original_filename
  end

  private

  def secure_token
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, SecureRandom.hex(4))
  end

  def store_dir
    main_dir = Digest::MD5.hexdigest(model.id.to_s)[0,2]
    "uploads/flexible_content/images/#{main_dir}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_limit: [800, 600]
end
