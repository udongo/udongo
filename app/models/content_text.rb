class ContentText < ActiveRecord::Base
  # TODO move to decorator
  def display_me_mofo
    content.to_s.html_safe
  end
end
