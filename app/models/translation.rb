class Translation < ActiveRecord::Base
  include Concerns::Loggable

  belongs_to :translatable, polymorphic: true

  validates :locale, :name, presence: true
  validates :name,
            uniqueness: { case_sensitive: false,
                          scope: [:translatable_type, :translatable_id, :locale] }
end

