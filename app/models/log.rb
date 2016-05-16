class Log < ActiveRecord::Base
  serialize :data, Hash

  belongs_to :loggable, polymorphic: true

  default_scope { order('created_at DESC, id DESC') }
end
