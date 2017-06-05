module Concerns
  module Taggable
    extend ActiveSupport::Concern

    included do
      has_many :tagged_items, as: :taggable, dependent: :destroy
    end

    def related(locale = I18n.locale)
      tagged_items = TaggedItem.where(tag_id: tags(locale).map(&:id), taggable_type: self.class.name)
      tagged_items.to_a.inject([]) do |memo,i|
        memo << self.class.find(i.taggable_id) unless i.taggable_id == id
        memo
      end.uniq
    end

    def tags(locale = I18n.locale)
      tagged_items.select { |i| i.tag.locale == locale.to_s }.map(&:tag)
    end

    def tags_string(locale = I18n.locale)
      tags(locale).map(&:name).join(',')
    end

    def taggable?
      true
    end

    def label_for_tag_link(locale)
      label = self.class.name

      if respond_to?(:translatable?) && translatable?
        if translation(locale).respond_to?(:name)
          label = translation(locale).name
        elsif translation(locale).respond_to?(:title)
          label = translation(locale).title
        end
      else
        if respond_to?(:name)
          label = name
        elsif respond_to?(:title)
          label = title
        end
      end

      label
    end
  end
end
