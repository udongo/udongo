module Udongo
  module Assets
    class Precompiler
      attr_reader :app

      def initialize(app)
        @app = app
      end

      def add(type, source)
        %W(#{Udongo::PATH}/#{source} #{Rails.root}/#{source}).each do |path|
          self.send("add_#{type}_to_precompile_list", path)
        end
      end

      def add_images_to_precompile_list(path)
        glob_files(path) do |f|
          app.config.assets.precompile += [f.split('images/').last]
        end
      end

      def add_javascripts_to_precompile_list(path)
        glob_files(path) do |f|
          app.config.assets.precompile += [f.split('javascripts/').last]
        end
      end

      def add_stylesheets_to_precompile_list(path)
        glob_files(path) do |f|
          filepath = f.split('stylesheets/').last
          filename = filepath.split('.').join('.')

          if File.extname(filename) == '.scss'
            app.config.assets.precompile += ["#{filename.gsub('.scss', '.css')}"]
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
