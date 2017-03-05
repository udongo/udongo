require 'mini_magick'

module Udongo
  module ImageManipulation
    module Base
      def initialize(file, width, height, options = {})
        @file = file
        @width = width
        @height = height
        @options = options
      end
    end
  end
end
