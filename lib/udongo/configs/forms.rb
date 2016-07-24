module Udongo
  module Configs
    class Forms
      def initialize
        @configs = {}
      end

      def method_missing(method, *args, &block)
        unless @configs[method]
          super unless ::Form.find_by(identifier: method)
          @configs[method] = OpenStruct.new(datagrid_fields: [], filter_fields: [])
        end

        @configs[method]
      end
    end
  end
end
