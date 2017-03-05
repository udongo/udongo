require 'mini_magick'

module Udongo
  module ImageManipulation
    class ResizeAndPad
      def initialize(file, width, height, options = {})
        @file = file
        @width = width
        @height = height
        @options = options
      end

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
