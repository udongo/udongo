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
class Udongo::Assets::Resize
  def initialize(asset)
    @asset = asset
  end

  def url(width = nil, height = nil, action: :resize_to_limit, options: {})
    # image_exists(width, height, action, options)
    # image exists?
    # > give back that url

    # no such image
    # > resize image
    # > give back that url

    if action.to_sym == :resize_to_limit
      resize_to_limit(width, height)
    end

  end

  private

  def resize_to_limit(width, height)
    md5 = Digest::MD5.hexdigest(@asset.id.to_s)
    main_dir = md5[0,2]
    second_dir = md5[2,2]

    unless File.exists? "#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/rtl-#{width}x#{height}-#{@asset.name_with_extension}"
      FileUtils.mkpath("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}")

      img = MiniMagick::Image.open(@asset.filename.path)
      img.resize "#{width}x#{height}>"
      img.write("#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/rtl-#{width}x#{height}-#{@asset.name_with_extension}")
    end

    "/uploads/assets/_cache/#{main_dir}/#{second_dir}/rtl-#{width}x#{height}-#{@asset.name_with_extension}"
  end

  def resize_to_fit(width, height)
    # [width]x[height]
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
