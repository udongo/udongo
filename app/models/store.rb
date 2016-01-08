class Store < ActiveRecord::Base
  belongs_to :storable, polymorphic: true, touch: true

  validates :name, :klass, presence: true
  validates :name,
            uniqueness: { case_sensitive: false,
                          scope: [:storable_type, :storable_id] }
end
