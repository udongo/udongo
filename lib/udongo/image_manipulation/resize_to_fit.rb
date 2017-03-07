require 'mini_magick'

module Udongo
  module ImageManipulation
    class ResizeToFit
      include Udongo::ImageManipulation::Base

      # Resize the image to fit within the specified dimensions while retaining
      # the original aspect ratio. The image may be shorter or narrower than
      # specified in the smaller dimension but will not be larger than the specified values.
      #
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
