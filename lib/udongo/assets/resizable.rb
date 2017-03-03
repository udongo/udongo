# FIXME: This can now be tested (and extended) separately from CarrierWave or
# Udongo's assets context.
#
# This essentially allows you to do model.image.url(width: 1024, height: 768)
# Width/height are passed in as a hash to be able to adhere to CarrierWave's
# url/path params.
module Udongo::Assets::Resizable
  def path(options = {})
    options.reverse_merge!(default_options)
    return super() if options[:width].nil? && options[:height].nil?
    url(options) # Trigger resize
    version_base(:path, options)
  end

  def url(options = {})
    options.reverse_merge!(default_options)
    return super(options) if options.is_a?(Hash) && options[:width].nil? && options[:height].nil?
    trigger_resize(version_base(path, options), options)
    version_base(:url, options)
  end

  private

  def default_options
    { action: :resize_to_limit, width: nil, height: nil, quality: 100, gravity: 'Center', background: :transparent }
  end

  def filter_action(action)
    unless %w(resize_to_limit resize_to_fit resize_to_fill resize_and_pad).include?(action.to_s)
      raise "No such resize action '#{action.to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
    end
  end

  def manipulation_options(options = {})
    options.except(*default_options.keys)
  end

  def write_image(img, path_to_version, options = {})
    img.quality(options[:quality])
    img.write(path_to_version)
    img
  end

  def trigger_resize(path_to_version, options = {})
    return if File.exists?(path_to_version)
    filter_action(options[:action])
    width, height = [options[:width], options[:height]]

    # FIXME: Get rid of repeated blocks
    case options[:action].to_sym
    when :resize_to_fill
      resize_to_fill(width, height, options[:gravity], combine_options: manipulation_options(options)) do |img|
        write_image(img, path_to_version, options)
      end
    when :resize_and_pad
      resize_and_pad(width, height, options[:background], options[:gravity], combine_options: manipulation_options(options)) do |img|
        write_image(img, path_to_version, options)
      end
    else
      self.send(options[:action], width, height, combine_options: manipulation_options(options)) do |img|
        write_image(img, path_to_version, options)
      end
    end
  end

  def version_base(type = :url, options = {})
    filename = "#{options[:width]}_#{options[:height]}_#{file.filename}"
    return File.join('/', store_dir, filename) if type.to_sym == :url
    File.join(Rails.root, 'public', store_dir, filename) # path requested
  end
end
