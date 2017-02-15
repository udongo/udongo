class Backend::PageTranslationForm < Backend::TranslationWithSeoForm
  attribute :title, String
  attribute :subtitle, String

  validates :title, presence: true

  def self.model_name
    Page.model_name
  end
end
