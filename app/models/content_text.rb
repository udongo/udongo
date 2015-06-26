class ContentText < ActiveRecord::Base
  # TODO move to decorator
  def display_me_mofo
    content.to_s.html_safe
  end

  # TODO write me
  def column
    # TODO once written, implement in the texts_controller.rb file
  end
end
