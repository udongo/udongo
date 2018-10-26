class RedirectDecorator < ApplicationDecorator
  delegate_all

  def status_badge
    @status_badge ||= Udongo::Redirects::StatusBadge.new(h, object)
  end

  def status_code_collection
    %w(301 303 307).map do |code|
      [I18n.t("b.msg.status_codes.#{code}"), code]
    end
  end

  def summary
    "#{I18n.t('b.from')} #{object.source_uri} #{I18n.t('b.to').downcase} #{object.destination_uri}"
  end

  def tooltip_identifier
    return :untested if working.nil?
    return :working if working?
    :broken
  end

  def tooltip_text
    h.t("b.msg.redirects.tooltips.#{tooltip_identifier}")
  end

  def truncated_uri(type, length: 50)
    value = object.send(type)

    return value if value.length <= length
    h.content_tag :span, data: { toggle: 'tooltip' }, title: value do
      h.truncate(value, length: length)
    end
  end
end
