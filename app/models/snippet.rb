class Snippet < ActiveRecord::Base
  include Concerns::Translatable

  translatable_fields :title, :content

  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
end
