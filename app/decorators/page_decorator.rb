class PageDecorator < Draper::Decorator
  delegate_all

  def options_for_parents
    Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end
  end

  def path(locale: I18n.locale, options: {})
    return h.send(route, options) if route.present?

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
    str << "/#{locale}" if Udongo.config.routes.prefix_with_locale?
    str << "/#{slugs.reverse.join('/')}"
    str
  end
end
