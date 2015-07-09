module Udongo
  module Assets
    class Precompiler
      attr_reader :app

      def initialize(app)
        @app = app
      end

      def add_images(path)
        add_image_files_to_precompile_list "#{Udongo::PATH}/#{path}"
        add_image_files_to_precompile_list "#{Rails.root}/#{path}"
      end

      def add_javascript(path)
        add_javascript_files_to_precompile_list "#{Udongo::PATH}/#{path}"
        add_javascript_files_to_precompile_list "#{Rails.root}/#{path}"
      end

      def add_stylesheets(path)
        add_stylesheet_files_to_precompile_list "#{Udongo::PATH}/#{path}"
        add_stylesheet_files_to_precompile_list "#{Rails.root}/#{path}"
      end

      private

      def add_image_files_to_precompile_list(path)
        glob_files(path) do |f|
          app.config.assets.precompile += [f.split('images/').last]
        end
      end

      def add_javascript_files_to_precompile_list(path)
        glob_files(path) do |f|
          app.config.assets.precompile += [f.split('javascripts/').last]
        end
      end

      def add_stylesheet_files_to_precompile_list(path)
        glob_files(path) do |f|
          filepath = f.split('stylesheets/').last
          filename = filepath.split('.')
          filename = filename.join('.')

          if File.extname(filename) == 'scss'
            app.config.assets.precompile += ["#{filename}.css"]
          else
            app.config.assets.precompile += [filepath]
          end
        end
      end

      def glob_files(path, &block)
        Dir.glob(path).each do |f|
          next if File.directory?(f)
          yield f
        end
      end
    end
  end
end
