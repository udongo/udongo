class Snippet < ActiveRecord::Base
  include Concerns::Translatable

  translatable_fields :title, :content

  validates :description, presence: true
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
end
