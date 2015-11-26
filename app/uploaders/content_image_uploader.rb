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

  process resize_to_limit: [2560, 1440]

  version :size_800x600 do
    process resize_to_limit: [800, 600]
  end

  version :size_1024x640 do
    process resize_to_limit: [1024, 640]
  end

  version :size_1280x800 do
    process resize_to_limit: [1280, 800]
  end

  version :size_1440x900 do
    process resize_to_limit: [1440, 900]
  end

  version :size_1680x1050 do
    process resize_to_limit: [1680, 1050]
  end

  version :size_1920x1200 do
    process resize_to_limit: [1920, 1200]
  end
end
