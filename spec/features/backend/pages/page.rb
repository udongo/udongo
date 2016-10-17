module Features
  module Pages
    class Page
      extend Capybara::DSL
      include Capybara::DSL

      extend WebMock::API
      include WebMock::API

      def initialize
        setup
      end

      def js_trigger(selector, event)
        page.execute_script("$('#{selector}').trigger('#{event}')");
      end

      def setup
      end
    end
  end
end

