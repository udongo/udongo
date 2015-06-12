require 'redcarpet'

class String
  def to_html(options = {})
    # Check out https://github.com/vmg/redcarpet for a list of all the options
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(self).html_safe
  end
end
