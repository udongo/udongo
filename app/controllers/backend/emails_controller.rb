class Backend::EmailsController < Backend::BaseController
  include Concerns::PaginationController

  before_action -> { breadcrumb.add t('b.emails'), backend_emails_path }

  def index
    @filter = Email.search(params[:q])
    @emails = paginate @filter.result(distinct: true).order('id DESC')
  end

  def show
    @email = Email.find params[:id]
  end

  def html_content
    @email = Email.find params[:id]
    render text: @email.html_content
  end
end
