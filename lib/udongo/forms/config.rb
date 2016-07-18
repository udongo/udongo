module Udongo
  module Forms
    module Config
      attr_reader :form

      def config
        @config ||= Udongo.config.form_submissions[form.identifier.to_sym]
      end
    end
  end
end
