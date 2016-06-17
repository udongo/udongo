class Udongo::Notification
  def translate_notice(notice, *args)
    return I18n.t("b.msg.#{notice}") if args.blank?

    if args.first.is_a?(Hash)
      I18n.t("b.msg.#{notice}", args.first)
    else
      I18n.t("b.msg.#{notice}", actor: I18n.t("b.#{args.first}"))
    end
  end
end
