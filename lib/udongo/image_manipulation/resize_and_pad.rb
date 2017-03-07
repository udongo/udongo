require_relative 'base'

module Udongo
  module ImageManipulation
    class ResizeAndPad
      include Udongo::ImageManipulation::Base

      # Resize the image to fit within the specified dimensions while retaining
      # the original aspect ratio. If necessary, will pad the remaining area
      # with the given color, which defaults to transparent (for gif and png,
      # white for jpeg).
      #
      # Possible values for options[:gravity] are:
      # NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast
      #
      def resize(path)
        gravity = @options.key?(:gravity) ? @options[:gravity] : 'Center'
        background = @options.key?(:background) ? @options[:background] : :transparant

        img = MiniMagick::Image.open(@file)
        img.combine_options do |cmd|
          cmd.thumbnail "#{@width}x#{@height}>"

          if background.to_sym == :transparent
            cmd.background 'rgba(255, 255, 255, 0.0)'
          else
            cmd.background background
          end

          cmd.gravity gravity
          cmd.extent "#{@width}x#{@height}"
        end

        img.write(path)
      end
    end
  end
end
