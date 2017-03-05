require 'mini_magick'

module Udongo
  module ImageManipulation
    class ResizeToFit
      def initialize(file, width, height, options = {})
        @file = file
        @width = width
        @height = height
        @options = options
      end

      def resize(path)
        img = MiniMagick::Image.open(@file)
        img.combine_options do |c|
          c.quality @options[:quality] if @options[:quality]
          c.resize "#{@width}x#{@height}"
        end

        img.write(path)
      end
    end
  end
end
