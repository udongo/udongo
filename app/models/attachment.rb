class Attachment < ApplicationRecord
  include Concerns::Sortable
  include Concerns::Visible

  belongs_to :asset
  belongs_to :attachable, polymorphic: true
end
