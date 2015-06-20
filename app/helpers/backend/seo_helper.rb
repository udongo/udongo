module Backend
  module SeoHelper
    def seo_base_path(request, form, locale)
      path_string = "#{form.object_name.pluralize}_#{locale}_path"

      if respond_to?(path_string)
        send path_string, only_path: false
      else
        "#{request.protocol}#{request.host}/#{locale}"
      end
    end
  end
end
