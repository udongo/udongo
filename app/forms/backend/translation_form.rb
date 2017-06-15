class Backend::TranslationForm < Udongo::Form
  attr_reader :model, :translation
  delegate :id, to: :model

  def initialize(model, translation)
    @model = model
    @translation = translation

    init_attribute_values(@translation)
  end

  def persisted?
    true
  end

  private

  def save_object
    init_object_values(@translation)
    @model.save
  end
end
