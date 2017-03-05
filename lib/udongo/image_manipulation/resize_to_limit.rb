require 'mini_magick'

module Udongo
  module ImageManipulation
    class ResizeToLimit

      # Resize the image to fit within the specified dimensions while retaining
      # the original aspect ratio. Will only resize the image if it is larger than the
      # specified dimensions. The resulting image may be shorter or narrower than specified
      # in the smaller dimension but will not be larger than the specified values.
      #
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
          c.resize "#{@width}x#{@height}>"
        end

        img.write(path)
      end
    end
  end
end
