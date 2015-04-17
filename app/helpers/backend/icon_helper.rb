module Backend
  module IconHelper
    def icon(name)
      content_tag :i, nil, class: "fi-#{name.to_s.gsub('_', '-')}"
    end
  end
end
