module PageHelper
  def page(identifier)
    Page.find_in_cache(identifier).decorate
  end
end
