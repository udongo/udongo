class Backend::NavigationItemTranslationForm < Udongo::Form
  attr_reader :navigation_item, :translation

  attribute :label, String
  attribute :path, String

  delegate :id, to: :navigation_item

  def initialize(navigation_item, translation)
    @navigation_item = navigation_item
    @translation = translation

    init_attribute_values(translation)
  end

  def self.model_name
    NavigationItem.model_name
  end

  def persisted?
    true
  end

  private

  def save_object
    init_object_values(@translation)
    @translation.save
  end
end
