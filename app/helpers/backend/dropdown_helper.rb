module Backend
  module DropdownHelper
    def options_for_content_types
      Udongo.config.flexible_content_types.map do |content_type|
        [I18n.t("b.msg.content_types.#{content_type}"), "Content#{content_type.to_s.camelcase}"]
      end
    end
  end
end
