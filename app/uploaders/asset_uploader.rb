class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process resize_to_limit: [2560, 2560], if: :image?

  def filename
    @name ||= "#{secure_token}.#{file.extension.downcase}" if original_filename
  end

  def path(options = {})
    options.reverse_merge!(action: :resize_to_limit, width: nil, height: nil)
    width, height = [options[:width], options[:height]]
    return super() if width.nil? && height.nil?
    url(options) # Trigger resize
    version_base(:path, width, height)
  end

  def url(options = {})
    options.reverse_merge!(action: :resize_to_limit, width: nil, height: nil)
    width, height = [options[:width], options[:height]]
    return super(options[:version]) if width.nil? && height.nil?
    path_to_version = version_base(path, width, height)

    unless File.exists?(path_to_version)
      case options[:action].to_sym
      when :resize_to_limit then resize_to_limit(width, height) { |img| img.write(path_to_version);img }
      when :resize_to_fit then resize_to_fit(width, height) { |img| img.write(path_to_version);img }
      when :resize_to_fill then resize_to_fill(width, height) { |img| img.write(path_to_version);img }
      when :resize_and_pad then resize_and_pad(width, height) { |img| img.write(path_to_version);img }
      else
        raise "No such resize action '#{options[:action].to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
      end
    end

    version_base(:url, width, height)
  end

  def version_base(type = :url, width, height)
    filename = "#{width}_#{height}_#{file.filename}"
    if type.to_sym == :url
      File.join('/', store_dir, filename)
    else
      File.join(Rails.root, 'public', store_dir, filename)
    end
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
end
