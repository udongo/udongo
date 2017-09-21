module Udongo
  module FlexibleContent
    class DuplicateLocale
      def initialize(object, source_locale, destination_locale)
        @object = object
        @source_locale = source_locale
        @destination_locale = destination_locale
      end

      def execute!
        check_for_flexible_content!
        check_for_different_locales!

        ActiveRecord::Base.transaction do
          clear_destination_content!

          @object.content_rows.by_locale(@source_locale).each do |source_row|
            new_row = duplicate_row(source_row)

            source_row.columns.each do |source_column|
              duplicate_column(new_row, source_column)
            end
          end
        end
      end

      private

      def check_for_flexible_content!
        return if @object.respond_to?(:flexible_content?) && @object.flexible_content?
        raise 'The object you provided does not have the FlexibleContent concern included.'
      end

      def check_for_different_locales!
        if @source_locale.to_s == @destination_locale.to_s
          raise "The source and destination locale are the same (#{@source_locale})"
        end
      end

      def clear_destination_content!
        @object.content_rows.by_locale(@destination_locale).destroy_all
      end

      def duplicate_row(source)
        @object.content_rows.create!(
          locale: @destination_locale,
          full_width: source.full_width?,
          horizontal_alignment: source.horizontal_alignment,
          vertical_alignment: source.vertical_alignment,
          background_color: source.background_color,
          no_gutters: source.no_gutters?,
          padding_top: source.padding_top,
          padding_bottom: source.padding_bottom,
          margin_top: source.margin_top,
          margin_bottom: source.margin_bottom,
          position: source.position
        )
      end

      def duplicate_column(new_row, source_column)
        widget = duplicate_widget(source_column.content)

        new_row.columns.create!(
          width_xs: source_column.width_xs,
          width_sm: source_column.width_sm,
          width_md: source_column.width_md,
          width_lg: source_column.width_lg,
          width_xl: source_column.width_xl,
          position: source_column.position,
          content: widget,
          external_reference: source_column.id
        )
      end

      def duplicate_widget(source)
        source.class.create!(
          widget_attributes(source)
        )
      end

      def widget_attributes(widget)
        attributes = widget.attributes
        attributes.delete('id')
        attributes.delete('created_at')
        attributes.delete('updated_at')
        attributes
      end
    end
  end
end
