class TaggedItem < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

  validates :tag,
            presence: true,
            uniqueness: { case_sensitive: false, scope: [:taggable_type, :taggable_id] }
end
