module Udongo
  module Configs
    class Forms
      def initialize
        @submission_datagrids = {}
      end

      def method_missing(method, *args, &block)
        form = ::Form.find_by!(identifier: method)
        @submission_datagrids[form.identifier.to_sym] = OpenStruct.new(datagrid_fields: [], filter_fields: [])
      end
    end
  end
end
