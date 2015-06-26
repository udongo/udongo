module Backend
  module DropdownHelper
    def options_for_content_types
      [
        [I18n.t('b.msg.content_types.text'), ContentText],
        [I18n.t('b.msg.content_types.image'), ContentImage]
      ]
    end
  end
end
