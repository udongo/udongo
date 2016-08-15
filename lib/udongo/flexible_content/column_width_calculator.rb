module Udongo
  module FlexibleContent
    class ColumnWidthCalculator
      attr_reader :row

      COLUMNS = %w(width_xs width_sm width_md width_lg width_xl)

      def initialize(row)
        @row = row
      end

      def calculate(field)
        field = field.to_sym
        return 12 if field == :width_xs || field == :width_sm

        difference = 12 - total(field)
        difference.zero? ? 12 : difference
      end

      def hashed_values
        COLUMNS.inject({}) do |result, column|
          result[column.to_sym] = calculate(column.to_sym)
          result
        end
      end

      def total(field)
        sum = row.columns.sum(field.to_sym).to_i
        return 12 if sum > 12
        sum
      end
    end
  end
end
