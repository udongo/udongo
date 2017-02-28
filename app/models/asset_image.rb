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
    str << "-#{@asset.read_attribute(:filename)}"
    str
  end

  def url(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    md5 = Digest::MD5.hexdigest(@asset.id.to_s)
    main_dir = md5[0,2]
    second_dir = md5[2,2]

    # if width/height are nil, you need to fetch the original file!

    if width.nil? && height.nil?
      return "/uploads/assets/#{main_dir}/#{second_dir}/#{@asset.read_attribute(:filename)}"
    end


    name = filename(width, height, options)

    unless File.exists?("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
      FileUtils.mkpath("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}")

      case options[:action].to_sym
        when :resize_to_limit
          resize_to_limit(width, height, options)
        else
          raise 'foo'
      end
    end

    "/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}"
  end

  def path(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)
    "#{Rails.root}/public#{url(width, height, options)}"
  end

  def resize_to_limit(width, height, options = {})
    options[:action] = :resize_to_limit

    md5 = Digest::MD5.hexdigest(@asset.id.to_s)
    main_dir = md5[0,2]
    second_dir = md5[2,2]

    name = filename(width, height, options)

    img = MiniMagick::Image.open(@asset.filename.path)
    img.combine_options do |c|
      c.quality(options[:quality]) if options[:quality]
      c.resize "#{width}x#{height}>"
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  def resize_to_fit(width, height)
    # [width]x[height]

    # resize picture
    #
  end

  def resize_to_fill(width, height, gravity = 'Center')
    # [width]
    # OR
    # x[height]
  end

  def resize_and_pad(width, height, gravity = 'Center', background = :transparant)
    # [width]x[height]
    # :transparant background for png
    # :white background for jpg
  end
end
