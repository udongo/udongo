class Backend::Redirects::TestController < Backend::BaseController
  before_action :find_model

  def detail
    # TODO: Provide another redirect test that does notn follow through to
    # the location
  end

  def simple
    if @redirect.works?(base_url: request.base_url)
      @redirect.working!

      respond_to do |format|
        format.js
        format.html { redirect_to :back, notice: test_notice(:works) }
      end
    else
      @redirect.broken!

      respond_to do |format|
        format.js
        format.html { redirect_to :back, notice: test_notice(:broken) }
      end
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
