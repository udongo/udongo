# FIXME: This can now be tested (and extended) separately from CarrierWave or
# Udongo's assets context.
#
# This essentially allows you to do model.image.url(width: 1024, height: 768)
# Width/height are passed in as a hash to be able to adhere to CarrierWave's
# url/path params.
module Udongo::Assets::Resizable
  def path(options = {})
    #return super(options) if resizer(options).resize_requested?
    #url(options) # Trigger resize
    resizer(options).path
  end

  def resizer(options = {})
    Udongo::Assets::Resizer.new(self, options)
  end

  def url(options = {})
    #return super(options) if resizer(options).resize_requested?
    #trigger_resize(version_base(path, options), options)
    resizer(options).url
  end

  private

  def filter_action(action)
    unless %w(resize_to_limit resize_to_fit resize_to_fill resize_and_pad).include?(action.to_s)
      raise "No such resize action '#{action.to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
    end
  end

  def manipulation_options(options = {})
    options.except(*resizer(options).default_options.keys)
  end

  def write_image(img, path_to_version, options = {})
    img.quality(options[:quality])
    img.write(path_to_version)
    img
  end
end
