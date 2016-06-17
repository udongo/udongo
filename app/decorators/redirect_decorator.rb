class RedirectDecorator < Draper::Decorator
  delegate_all

  def status_code_collection
    %w(301 303 307).map do |code|
      [I18n.t("b.msg.status_codes.#{code}"), code]
    end
  end

  def summary
    "#{I18n.t('b.from')} #{object.source_uri} #{I18n.t('b.to').downcase} #{object.destination_uri}"
  end
end
