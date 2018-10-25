class Backend::Redirects::TestController < Backend::BaseController
  before_action :find_model

  def detail
    # TODO:
  end

  def simple
    if @redirect.works?(base_url: request.base_url)
      @redirect.working!
      redirect_to :back, notice: test_notice(:works)
    else
      @redirect.broken!
      redirect_to :back, alert: test_notice(:broken)
    end
  end

  private

  def find_model
    @redirect ||= Redirect.find(params[:id]).decorate
  end

  def test_notice(key)
    t("b.msg.redirects.#{key}",
      source: @redirect.source_uri,
      destination: @redirect.destination_uri
     )
  end
end
