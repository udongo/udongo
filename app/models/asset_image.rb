require 'mini_magick'
require 'fileutils'

# When presented with a gravity argument, one of the following values is
# possible.
# - NorthWest
# - North
# - NorthEast
# - West
# - Center (default)
# - East
# - SouthWest
# - South
# - SouthEast
class AssetImage
  def initialize(asset)
    @asset = asset
  end

  def filename(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    str = ''
    str << 'rtl' if options[:action].to_sym == :resize_to_limit
    str << "-q#{options[:quality]}" if options[:quality]
    # TODO add gravity if present
    str << "-#{width}x#{height}"
    str << "-#{@asset.actual_filename}"
    str
  end

  def url(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    if width.nil? && height.nil?
      return "/uploads/assets/#{main_dir}/#{second_dir}/#{@asset.actual_filename}"
    end

    name = filename(width, height, options)

    unless File.exists?("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
      FileUtils.mkpath("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}")

      case options[:action].to_sym
        when :resize_to_limit
          resize_to_limit(width, height, options)
        else
          resize_to_fit(width, height, options)
      end
    end

    "/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}"
  end

  def path(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)
    "#{Rails.root}/public#{url(width, height, options)}"
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the original aspect ratio. Will only resize the image if it is larger than the
  # specified dimensions. The resulting image may be shorter or narrower than specified
  # in the smaller dimension but will not be larger than the specified values.
  #
  def resize_to_limit(width, height, options = {})
    options[:action] = :resize_to_limit

    name = filename(width, height, options)

    img = MiniMagick::Image.open(@asset.filename.path)
    img.combine_options do |c|
      c.quality(options[:quality]) if options[:quality]
      c.resize "#{width}x#{height}>"
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the original aspect ratio. The image may be shorter or narrower than
  # specified in the smaller dimension but will not be larger than the specified values.
  #
  def resize_to_fit(width, height, options = {})
    options[:action] = :resize_to_fit

    name = filename(width, height, options)

    img = MiniMagick::Image.open(@asset.filename.path)
    img.combine_options do |c|
      c.quality(options[:quality]) if options[:quality]
      c.resize "#{width}x#{height}"
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the aspect ratio of the original image. If necessary, crop the image in the
  # larger dimension.
  #
  def resize_to_fill(width, height, gravity = 'Center')
    # [width]
    # OR
    # x[height]
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the original aspect ratio. If necessary, will pad the remaining area
  # with the given color, which defaults to transparent (for gif and png,
  # white for jpeg).
  #
  def resize_and_pad(width, height, gravity = 'Center', background = :transparant)
    # [width]x[height]
    # :transparant background for png
    # :white background for jpg
  end

  def main_dir
    @main_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[0,2]
  end

  def second_dir
    @second_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[2,2]
  end
end
