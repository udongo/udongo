module Backend
  module DropdownHelper
    def options_for_content_types
      Udongo.config.flexible_content.types.map do |content_type|
        [I18n.t("b.msg.content_types.#{content_type}"), "Content#{content_type.to_s.camelcase}"]
      end
    end

    def options_for_column_widths
      (1..12).to_a.reverse.map do |i|
        ["#{i}/12", i]
      end
    end
  end
end
