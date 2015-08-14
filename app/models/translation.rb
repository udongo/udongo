class Translation < ActiveRecord::Base
  include Concerns::Loggable
  include Concerns::Locale

  belongs_to :translatable, polymorphic: true

  after_save :flush_cache

  validates :locale, :name, presence: true
  validates :name,
            uniqueness: { case_sensitive: false,
                          scope: [:translatable_type, :translatable_id, :locale] }

  private

  def flush_cache
    Rails.cache.delete [:translation, translatable.class.name, translatable.id, locale, name]
  end
end

