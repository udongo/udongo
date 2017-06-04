module LinkHelper
  def link_to_show(value)
    link_to(
      icon(:search),
      path_from_string_or_object(value),
      title: t('b.view')
    )
  end

  def link_to_edit(value)
    link_to(
      icon(:pencil_square_o),
      path_from_string_or_object(value, 'edit_'),
      title: t('b.edit')
    )
  end

  def link_to_edit_translation(object, locale = Udongo.config.i18n.app.default_locale)
    str = "edit_translation_#{Udongo::ObjectPath.find(object)}"
    url = send(str, *Udongo::ObjectPath.remove_symbols(object), locale)

    link_to_edit(url)
  end

  def link_to_delete(value)
    link_to(
      icon(:trash),
      path_from_string_or_object(value),
      method: :delete,
      data: { confirm: t('b.msg.confirm') },
      title: t('b.delete')
    )
  end

  def path_from_string_or_object(value, prefix = nil)
    return value if value.is_a?(String)

    str = "#{prefix}#{Udongo::ObjectPath.find(value)}"
    send(str, *Udongo::ObjectPath.remove_symbols(value))
  end
end
