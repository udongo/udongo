module Backend
  module IconHelper
    def icon(name)
      "<i class=\"fi-#{name.to_s.gsub('_', '-')}\"></i>".html_safe
    end
  end
end
