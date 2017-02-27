class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def filename
    @name ||= "#{secure_token}.#{file.extension.downcase}" if original_filename
  end

  private

  def extension_white_list
    %w(doc docx gif jpeg jpg pdf png txt xls xlsx)
  end

  def secure_token
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, SecureRandom.hex(4))
  end

  def store_dir
    main_dir = Digest::MD5.hexdigest(model.id.to_s)[0,2]
    second_dir = Digest::MD5.hexdigest(model.id.to_s)[2,2]
    "uploads/assets/#{main_dir}/#{second_dir}"
  end

  def image?(new_file)
    new_file.content_type.include? 'image'
  end

  process resize_to_limit: [2560, 2560], if: :image?
end
