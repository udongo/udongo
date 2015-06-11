require 'redcarpet'

module Udongo
  class Markdown
    def self.to_html(string, options = {})
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(string.to_s).html_safe
    end
  end
end
