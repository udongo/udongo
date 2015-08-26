class Log < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true

  default_scope { order('created_at DESC') }
end
