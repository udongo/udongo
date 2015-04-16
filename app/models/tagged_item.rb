class TaggedItem < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

  after_destroy do
    tag.destroy unless TaggedItem.exists?(tag_id: tag.id)
  end

  validates :tag,
            presence: true,
            uniqueness: { case_sensitive: false, scope: [:taggable_type, :taggable_id] }
end

