class Backend::NavigationItemTranslationForm < Backend::TranslationForm
  attribute :label, String
  attribute :path, String

  def self.model_name
    NavigationItem.model_name
  end
end
