module Backend
  module IconHelper
    def icon(name)
      content_tag :i, nil, class: "fi-#{name.to_s.gsub('_', '-')}"
    end

    def icon_and_label(name, label)
      "#{icon(name)}&nbsp;#{I18n.t(label)}".html_safe
    end
  end
end
