module Udongo
  module Configs
    class Forms
      def method_missing(method, *args, &block)
        form = ::Form.find_by(identifier: method)
        @submission_datagrids ||= OpenStruct.new(datagrid_fields: [], filter_fields: [])
      end
    end
  end
end
