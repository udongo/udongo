module Udongo
  module Configs
    class Assets
      include Virtus.model

      attribute :image_white_list, Array, default: %w(gif jpeg jpg png)
      attribute :file_white_list, Array, default: %w(doc docx pdf txt xls xlsx)
    end
  end
end
