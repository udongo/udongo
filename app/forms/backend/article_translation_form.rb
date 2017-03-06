class Backend::ArticleTranslationForm < Backend::TranslationWithSeoForm
  attribute :title, String
  attribute :summary, String

  validates :title, :summary, presence: true

  def self.model_name
    Article.model_name
  end
end
