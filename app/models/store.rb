class Store < ApplicationRecord
  belongs_to :storable, polymorphic: true, touch: true

  serialize :value

  validates :collection, :name, presence: true
  validates :name,
            uniqueness: { case_sensitive: false,
                          scope: [:collection, :storable_type, :storable_id] }
end
