# FIXME: This can now be tested (and extended) separately from CarrierWave or
# Udongo's assets context.
#
# This essentially allows you to do model.image.url(width: 1024, height: 768)
# Width/height are passed in as a hash to be able to adhere to CarrierWave's
# url/path params.
module Udongo::CarrierwaveVersioningOnDemand
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
    return File.join('/', store_dir, filename) if type.to_sym == :url
    File.join(Rails.root, 'public', store_dir, filename) # path requested
  end
end
