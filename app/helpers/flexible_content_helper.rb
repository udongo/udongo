module FlexibleContentHelper
  def importable_locales(model, current_locale)
    Udongo.config.i18n.app.locales.select do |lo|
      lo.to_s != current_locale.to_s && model.content_rows.by_locale(lo).any?
    end
  end
end
