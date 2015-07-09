module Udongo
  module Assets
    class Loader
      attr_reader :files
      attr_accessor :view

      def initialize
        @files = []
      end

      def add(file)
        file = file.split('.js').first if file.include?('.js')
        file = file.split('.scss').first if file.include?('.scss')
        file = file.split('.css').first if file.include?('.css')
        @files.push file
      end

      def exists?(file)
        @files.include?(file)
      end

      def load_css(file, media = :screen)
        load_file(file, :stylesheets) { @view.stylesheet_link_tag(file, media: media) }
      end

      def load_file(file, target, &block)
        if block_given? && !exists?(file)
          add file
          @view.content_for(target) { yield file }
          return true
        end
        false
      end

      def load_js(file, target = :javascripts)
        load_file(file, target) { @view.javascript_include_tag(file) }
      end
    end
  end
end
