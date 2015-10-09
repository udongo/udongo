class PageDecorator < Draper::Decorator
  delegate_all

  def options_for_parents(disabled: nil)
    list = ::Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end

    h.options_for_select(list, selected: parent_id, disabled: disabled)
  end

  def path(locale: I18n.locale, options: {})
    if route.present?
      h.send(route, options)
    else
      slugs = []

      parents.each do |p|
        if p.route.present?
          slugs << h.send(p.route, options)
          return slugs.reverse.join('/')
        else
          slugs << p.seo(locale).slug
        end
      end

      str = ''
      str << "/#{locale}" if Udongo.config.prefix_routes_with_locale?
      str << "/#{slugs.reverse.join('/')}"
      str
    end
  end
end
