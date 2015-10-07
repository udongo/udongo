class PageDecorator < Draper::Decorator
  delegate_all

  def options_for_parents(disabled: nil)
    list = ::Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end

    h.options_for_select(list, selected: parent_id, disabled: disabled)
  end

  # TODO calculate the actual path if no route is set in the page
  # TODO take into account that some sites don't use a language prefix!
  # this might mean that we need to configure this in the udongo config.
  # eg prefix_routes_with_locale = false (default = true)
  def path(options = {})
    route.present? ? h.send(route, options) : '/'
  end
end
