class Udongo::Notification
  def initialize(notice)
    @notice = notice
  end

  def build_hash(actor)
    { actor: I18n.t("b.#{actor}") }
  end

  def label
    "b.msg.#{@notice}"
  end

  def translate(vars = nil)
    return I18n.t(label) if vars.blank?
    vars = build_hash(vars) unless vars.is_a?(Hash)
    I18n.t(label, vars)
  end
end
