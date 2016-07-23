require 'will_paginate/view_helpers/action_view'

module Udongo
  module WillPaginate
    class Renderer < ::WillPaginate::ActionView::LinkRenderer

      protected

      def page_number(page)
        list_classes = 'page-item'
        list_classes += ' active' if page == current_page
        tag(:li, link(page, page, class: 'page-link', rel: rel_value(page)), class: list_classes)
      end

      def previous_or_next_page(page, text, classname)
        list_classes = [classname[0..3], classname, 'page-item']
        list_classes.push('disabled') unless page
        tag(:li, link(text, page || '#', class: 'page-link'), class: list_classes.join(' '))
      end

      def html_container(html)
        tag(:nav, tag(:ul, html, container_attributes))
      end

      def gap
        tag(:li, link(super, '#', class: 'page-link'), class: 'page-item disabled')
      end
    end
  end
end
