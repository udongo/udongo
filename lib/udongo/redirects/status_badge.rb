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

    def html
      @view.content_tag(:span, @redirect.status_code, class: "badge badge-#{css_class}")
    end
  end
end
