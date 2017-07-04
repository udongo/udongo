class Backend::Pages::BaseController < Backend::BaseController
  before_action :find_page
  before_action do
    breadcrumb.add t('b.pages'), backend_pages_path
    breadcrumb.add @page.description, edit_backend_page_path(@page)
  end

  def find_page
    @page = Page.find params[:page_id]
  end
end
