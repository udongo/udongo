class ContentText < ActiveRecord::Base
  def column
    ::ContentColumn.where(content_type: self.class.name, content_id: id).take
  end
end
