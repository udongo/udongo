class Backend::NavigationItemForm < Udongo::Form
  attr_reader :navigation_item

  attribute :page_id, Integer
  attribute :extra, String

  delegate :id, to: :navigation_item

  def self.model_name
    NavigationItem.model_name
  end

  def persisted?
    !@navigation_item.new_record?
  end

  private

  def save_object
    init_object_values(@navigation_item)
    @navigation_item.save!
  end
end
