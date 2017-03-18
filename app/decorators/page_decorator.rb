class PageDecorator < ApplicationDecorator
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

    "/#{locale}/#{slugs.reverse.join('/')}"
  end

  def url(locale: I18n.locale, options: {})
    prefix = Rails.configuration.force_ssl ? 'https://' : 'http://'
    host = Udongo.config.base.host
    params = { locale: locale, options: options }

    "#{prefix}#{host}#{path(params)}"
  end
end
