class Log < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true

  validates :loggable_id, :loggable_type, presence: true

  default_scope { order('created_at DESC') }
end

