# FIXME: This can now be tested (and extended) separately from CarrierWave or
# Udongo's assets context.
#
# This essentially allows you to do model.image.url(width: 1024, height: 768)
# Width/height are passed in as a hash to be able to adhere to CarrierWave's
# url/path params.
module Udongo::CarrierwaveVersioningOnDemand
  def path(options = {})
    options.reverse_merge!(default_options)
    return super() if options[:width].nil? && options[:height].nil?
    url(options) # Trigger resize
    version_base(:path, options)
  end

  def url(options = {})
    options.reverse_merge!(default_options)
    return super(options[:version]) if options[:width].nil? && options[:height].nil?
    trigger_resize(version_base(path, options), options)
    version_base(:url, options)
  end

  private

  def default_options
    { action: :resize_to_limit, width: nil, height: nil }
  end

  def trigger_resize(path_to_version, options = {})
    unless File.exists?(path_to_version)
      # The block allows us to override the location of the written file.
      self.send(options[:action], options[:width], options[:height]) do |img|
        img.write(path_to_version)
        img
      end
    end
  rescue
    raise "No such resize action '#{options[:action].to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
  end

  def version_base(type = :url, options = {})
    filename = "#{options[:width]}_#{options[:height]}_#{file.filename}"
    return File.join('/', store_dir, filename) if type.to_sym == :url
    File.join(Rails.root, 'public', store_dir, filename) # path requested
  end
end
