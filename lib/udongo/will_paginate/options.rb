module Udongo
  module WillPaginate
    class Options
      include ActionView::Helpers::TagHelper

      def initialize(options = {})
        @options = options || {}
      end

      def defaults
        {
          class: 'pagination',
          inner_window: 1,
          outer_window: 0,
          renderer: Udongo::WillPaginate::Renderer,
          previous_label: previous_label,
          next_label: next_label
        }
      end

      def next_label
        nav_label('&rarr;', 'next_label')
      end

      def previous_label
        nav_label('&larr;', 'previous_label')
      end

      def nav_label(default_value, sr_only_value)
        string = content_tag(:span, default_value.html_safe, aria: { hidden: true })
        string += content_tag(:span, I18n.t("will_paginate.#{sr_only_value}"), class: 'sr-only')
        string.html_safe
      end

      def values
        @options.reverse_merge!(defaults)
      end
    end
  end
end
