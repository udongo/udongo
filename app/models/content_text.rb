class ContentText < ActiveRecord::Base
  def display_me_mofo
    content.to_s.html_safe
  end
end
