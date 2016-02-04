class Address < ActiveRecord::Base
  include Concerns::Emailable

  belongs_to :addressable, polymorphic: true
end
