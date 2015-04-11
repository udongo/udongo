class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates :addressable_id, :addressable_type, presence: true
end

