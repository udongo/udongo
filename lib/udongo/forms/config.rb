module Udongo
  module Forms
    module Config
      attr_reader :form

      def config
        Udongo.config.forms.send(form.identifier.to_sym)
      end
    end
  end
end
