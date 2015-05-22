class Backend::PolymorphicHelper
  include Rails.application.routes.url_helpers

  def initialize(type: nil, id: nil)
    @type = type
    @id = id
  end

  def filtered?
    type_exists? && @type.present? && @id.present?
  end

  def filtered_url(polymorphic_name)
    params = {
      "#{polymorphic_name}_type" => @type,
      "#{polymorphic_name}_id" => @id
    }

    send "backend_#{@type.underscore.pluralize}_path", params
  end

  def model
    filtered? ? @type.constantize.find(@id) : false
  end

  def model_description
    if model.respond_to?(:translation)
      model_title model.translation(Udongo::Config.default_locale)
    else
      model_title model
    end
  end

  def model_path
    send "edit_backend_#{@type.underscore}_path", model
  end

  def model_translation
    I18n.t("b.#{@type.underscore}").downcase
  end

  def type_exists?
    begin
      klass = Module.const_get(@type.to_s)
      return klass.is_a?(Class)
    rescue NameError
      return false
    end
  end

  private

  def model_title(instance)
    begin
      instance.title
    rescue
      begin
        instance.name
      rescue
        false
      end
    end
  end
end
