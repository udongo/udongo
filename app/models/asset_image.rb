require 'mini_magick'
require 'fileutils'

class AssetImage
  def initialize(asset)
    @asset = asset
  end

  def filename(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    str = ''
    str << 'rtlmt' if options[:action].to_sym == :resize_to_limit
    str << 'rtft' if options[:action].to_sym == :resize_to_fit
    str << 'rtfl' if options[:action].to_sym == :resize_to_fill
    str << 'rapd' if options[:action].to_sym == :resize_and_pad
    str << "-q#{options[:quality]}" if options[:quality]

    if options[:gravity]
      str << '-g' + options[:gravity].to_s.underscore.split('_').map { |s| s[0,1] }.join
    end

    if options[:background]
      str << "-b#{options[:background].to_s.parameterize}"
    end

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
          resize_to_limit width, height, options
        when :resize_to_fit
          resize_to_fit width, height, options
        when :resize_to_fill
          resize_to_fill width, height, options
        when :resize_and_pad
          resize_and_pad width, height, options
        else
          raise "No such resize action '#{options[:action].to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
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
      c.quality options[:quality] if options[:quality]
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
      c.quality options[:quality] if options[:quality]
      c.resize "#{width}x#{height}"
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the aspect ratio of the original image. If necessary, crop the image in the
  # larger dimension.
  #
  # Possible values for options[:gravity] are:
  # NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast
  def resize_to_fill(width, height, options = {})
    options[:action] = :resize_to_fill
    gravity = options.key?(:gravity) ? options[:gravity] : 'Center'

    name = filename(width, height, options)
    img = MiniMagick::Image.open(@asset.filename.path)
    cols, rows = img[:dimensions]

    img.combine_options do |cmd|
      if width != cols || height != rows
        scale_x = width/cols.to_f
        scale_y = height/rows.to_f

        if scale_x >= scale_y
          cols = (scale_x * (cols + 0.5)).round
          rows = (scale_x * (rows + 0.5)).round
          cmd.resize "#{cols}"
        else
          cols = (scale_y * (cols + 0.5)).round
          rows = (scale_y * (rows + 0.5)).round
          cmd.resize "x#{rows}"
        end
      end

      cmd.quality options[:quality] if options.key?(:quality)
      cmd.gravity gravity
      cmd.background 'rgba(255,255,255,0.0)'
      cmd.extent "#{width}x#{height}" if cols != width || rows != height
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  # Resize the image to fit within the specified dimensions while retaining
  # the original aspect ratio. If necessary, will pad the remaining area
  # with the given color, which defaults to transparent (for gif and png,
  # white for jpeg).
  #
  def resize_and_pad(width, height, options = {})
    options[:action] = :resize_and_pad
    gravity = options.key?(:gravity) ? options[:gravity] : 'Center'
    background = options.key?(:background) ? options[:background] : :transparant

    name = filename(width, height, options)
    img = MiniMagick::Image.open(@asset.filename.path)

    img.combine_options do |cmd|
      cmd.thumbnail "#{width}x#{height}>"

      if options[:background].to_sym == :transparent
        cmd.background 'rgba(255, 255, 255, 0.0)'
      else
        cmd.background background
      end

      cmd.gravity gravity
      cmd.extent "#{width}x#{height}"
    end

    img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{name}")
  end

  def main_dir
    @main_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[0,2]
  end

  def second_dir
    @second_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[2,2]
  end
end
