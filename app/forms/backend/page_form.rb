class Backend::PageForm < Udongo::Form
  attr_reader :page

  attribute :parent_id, Integer
  attribute :description, String
  attribute :visible, Axiom::Types::Boolean

  validates :description, presence: true

  delegate :id, to: :page

  def self.model_name
    Page.model_name
  end

  def persisted?
    !@page.new_record?
  end

  private

  def save_object
    init_object_values(@page)
    @page.save!
  end
end
