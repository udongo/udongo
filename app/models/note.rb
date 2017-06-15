class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true

  default_scope { order('created_at DESC') }

  validates :content, presence: true
end
