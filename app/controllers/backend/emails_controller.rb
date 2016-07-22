class Backend::EmailsController < BackendController
  include Concerns::PaginationController

  before_action -> { breadcrumb.add t('b.emails'), backend_emails_path }

  def index
    @emails = paginate Email.all.order('id DESC')
  end

  def show
    @email = Email.find params[:id]
  end

  def html_content
    @email = Email.find params[:id]
    render text: @email.html_content
  end
end
