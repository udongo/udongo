class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def filename
    @name ||= "#{secure_token}.#{file.extension.downcase}" if original_filename
  end

  private

  def extension_white_list
    if model.image?
      %w(gif jpeg jpg png)
    else
      %w(doc docx gif jpeg jpg pdf png txt xls xlsx)
    end
  end

  def secure_token
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, SecureRandom.hex(4))
  end

  def store_dir
    md5 = Digest::MD5.hexdigest(model.id.to_s)
    "uploads/assets/#{md5[0,2]}/#{md5[2,2]}"
  end

  def image?(new_file)
    new_file.content_type.include? 'image'
  end

  process resize_to_limit: [2560, 2560], if: :image?
end
