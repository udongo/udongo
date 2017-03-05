require 'fileutils'

class AssetImage
  def initialize(asset)
    @asset = asset
  end

  def filename(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    str = options[:action].to_s.split('_').last

    if options[:quality]
      str << '-q' + options[:quality].to_s
    end

    if options[:gravity]
      str << '-g' + options[:gravity].to_s.underscore.split('_').map { |s| s[0,1] }.join
    end

    if options[:background]
      str << '-b' + options[:background].to_s.parameterize
    end

    str << "-#{width}x#{height}-#{@asset.actual_filename}"
  end

  def url(width = nil, height = nil, options = {})
    options[:action] = :resize_to_limit unless options.key?(:action)

    if width.nil? && height.nil?
      return "/uploads/assets/#{main_dir}/#{second_dir}/#{@asset.actual_filename}"
    end

    name = filename(width, height, options)

    unless File.exists?(actual_path(name))
      FileUtils.mkpath(File.dirname(actual_path(name)))

      case options[:action].to_sym
        when :resize_to_limit then resize_to_limit(width, height, options)
        when :resize_to_fit then resize_to_fit(width, height, options)
        when :resize_to_fill then resize_to_fill(width, height, options)
        when :resize_and_pad then resize_and_pad(width, height, options)
        else
          raise "No such resize action '#{options[:action].to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
      end
    end

    actual_url(name)
  end

  def actual_url(calculated_filename)
    "/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{calculated_filename}"
  end

  def path(width = nil, height = nil, options = {})
    url(width, height, options) # Trigger the actual resize
    actual_path(filename(width, height, options))
  end

  def actual_path(calculated_filename)
    "#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{calculated_filename}"
  end

  private

  def resize_to_limit(width, height, options = {})
    Udongo::ImageManipulation::ResizeToLimit.new(
      @asset.filename.path, width, height, options
    ).resize(
      actual_path(filename(width, height, options))
    )
  end

  def resize_to_fit(width, height, options = {})
    Udongo::ImageManipulation::ResizeToFit.new(
      @asset.filename.path, width, height, options
    ).resize(
      actual_path(filename(width, height, options))
    )
  end

  def resize_to_fill(width, height, options = {})
    Udongo::ImageManipulation::ResizeToFill.new(
      @asset.filename.path, width, height, options
    ).resize(
      actual_path(filename(width, height, options))
    )
  end

  def resize_and_pad(width, height, options = {})
    Udongo::ImageManipulation::ResizeAndPad.new(
      @asset.filename.path, width, height, options
    ).resize(
      actual_path(filename(width, height, options))
    )
  end

  def main_dir
    @main_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[0,2]
  end

  def second_dir
    @second_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[2,2]
  end
end
