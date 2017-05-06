module NavigationHelper
  def navigation(identifier)
    ::Navigation.find_in_cache(identifier)
  end
end
