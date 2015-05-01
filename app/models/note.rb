class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true

  validates :content, presence: true

  default_scope { order('created_at DESC') }
end
