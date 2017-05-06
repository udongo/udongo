require 'fileutils'

module Udongo
  module Assets
    class Resizer
      def initialize(asset)
        @asset = asset
      end

      def filename(width = nil, height = nil, options = {})
        action = options.key?(:action) ? options[:action] : :resize_to_limit
        quality = options[:quality]
        gravity = options[:gravity].to_s.underscore.split('_').map { |s| s[0,1] }.join
        background = options[:background].to_s.parameterize

        str = action.to_s.split('_').last
        str << "-q#{quality}" if quality.present?
        str << "-g#{gravity}" if gravity.present?
        str << "-b#{background}" if background.present?
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

          unless resize_action_allowed? options[:action]
            raise "No such resize action '#{options[:action].to_s}'. Available are: resize_to_limit, resize_to_fit, resize_to_fill and resize_and_pad."
          end

          trigger_resize(width, height, options)
        end

        actual_url(name)
      end

      def actual_url(calculated_filename)
        "/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{calculated_filename}"
      end

      def path(width = nil, height = nil, options = {})
        url(width, height, options) # Trigger the actual resize (if needed)
        actual_path(filename(width, height, options))
      end

      def actual_path(calculated_filename)
        "#{Rails.root}/public/uploads/assets/_cache/#{main_dir}/#{second_dir}/#{calculated_filename}"
      end

      private

      def trigger_resize(width, height, options = {})
        "Udongo::ImageManipulation::#{options[:action].to_s.camelcase}".constantize.new(
          @asset.filename.path, width, height, options
        ).resize(
          actual_path(filename(width, height, options))
        )
      end

      def resize_action_allowed?(action)
        %w(resize_to_limit resize_to_fit resize_to_fill resize_and_pad).include?(action.to_s)
      end

      def main_dir
        @main_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[0,2]
      end

      def second_dir
        @second_dir ||= Digest::MD5.hexdigest(@asset.id.to_s)[2,2]
      end
    end
  end
end
