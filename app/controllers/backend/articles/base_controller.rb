class Backend::Articles::BaseController < Backend::BaseController
  before_action :find_article
  before_action do
    breadcrumb.add t('b.articles'), backend_articles_path
    breadcrumb.add @article.title
  end

  def find_article
    @article = Article.find params[:article_id]
  end
end
