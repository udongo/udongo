module Udongo::Redirects
  class StatusBadge
    attr_reader :view

    # TODO: find out why Module.takes does not override in an engine env.
    def initialize(view, redirect)
      @view = view
      @redirect = redirect
    end

    def css_class
      return 'success' if @redirect.working?
      return 'info' if @redirect.working.nil?
      'danger'
    end

    def html(attributes = {})
      attributes.reverse_merge!(class: "badge badge-#{css_class}")
      @view.content_tag(:span, @redirect.status_code, attributes)
    end

    def icon
      return '' unless icon_identifier
      @view.icon(icon_identifier)
    end

    def icon_identifier
      return :question_circle if @redirect.working.nil?
      return :check_circle if @redirect.working?
      :times_circle
    end
  end
end
