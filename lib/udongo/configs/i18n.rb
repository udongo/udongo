module Udongo
  module Configs
    class I18n
      attr_reader :app, :cms

      def initialize
        @app = Udongo::Configs::I18ns::App.new
        @cms = Udongo::Configs::I18ns::Cms.new
      end
    end
  end
end
