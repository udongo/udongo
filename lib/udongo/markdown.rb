require 'redcarpet'

module Udongo
  class Markdown
    # Check out https://github.com/vmg/redcarpet for a list of all the options
    def self.to_html(string, options = {})
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(string.to_s).html_safe
    end
  end
end
