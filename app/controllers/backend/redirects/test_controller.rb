class Backend::Redirects::TestController < Backend::BaseController
  before_action :find_model

  # The follow_location param determines the difference between a redirect trace
  # that runs through every nested redirect and one that stops at the first
  # redirect in the trace.
  # (A nested redirect meaning that the destination of one redirect is the
  # source of another)
  def resolve
    respond_to do |format|
      format.js do
        # The last redirect in a chain should always follow its location through,
        # because that's the only way afaik to retrieve 404/500 and other faulty
        # status codes, instead of the default 301.
        vars = { base_url: request.base_url, follow_location: @redirect.next_in_chain.blank? }

        if @redirect.resolves?(vars)
          @redirect.working!
        else
          @redirect.broken!
        end
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
