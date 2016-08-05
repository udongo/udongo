module Udongo
  module FlexibleContent
    class ColumnWidthCalculator
      attr_reader :row

      COLUMNS = %w(width_xs width_sm width_md width_lg width_xl)

      def initialize(row)
        @row = row
      end

      def calculate(field)
        difference = 12 - total(field)
        return 12 if difference.zero? || field.to_sym == :width_xs
        difference
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
