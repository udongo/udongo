class Udongo::Notification
  def translate_notice(notice, actor)
    I18n.t("b.msg.#{notice}", actor: I18n.t("b.#{actor}"))
  end
end
