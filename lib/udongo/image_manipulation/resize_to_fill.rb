require 'mini_magick'

module Udongo
  module ImageManipulation
    class ResizeToFill
      def initialize(file, width, height, options = {})
        @file = file
        @width = width
        @height = height
        @options = options
      end

      def resize(path)
        gravity = @options.key?(:gravity) ? @options[:gravity] : 'Center'

        img = MiniMagick::Image.open(@file)
        cols, rows = img[:dimensions]

        img.combine_options do |cmd|
          if @width != cols || @height != rows
            scale_x = @width/cols.to_f
            scale_y = @height/rows.to_f

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

          cmd.quality @options[:quality] if @options.key?(:quality)
          cmd.gravity gravity
          cmd.background 'rgba(255,255,255,0.0)'
          cmd.extent "#{@width}x#{@height}" if cols != @width || rows != @height
        end

        img.write(path)
      end
    end
  end
end
