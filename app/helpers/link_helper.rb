module LinkHelper
  def link_to_show(value)
    if value.is_a?(String)
      url = value
    else
      str = Udongo::ObjectPath.find(value)
      url = send(str, *Udongo::ObjectPath.remove_symbols(value))
    end

    # str = Udongo::ObjectPath.find(object)

    link_to(
      icon(:search),
      url,
      title: t('b.view')
    )
  end

  def link_to_edit(value)
    if value.is_a?(String)
      url = value
    else
      str = "edit_#{Udongo::ObjectPath.find(value)}"
      url = send(str, *Udongo::ObjectPath.remove_symbols(value))
    end

    link_to(
      icon(:pencil_square_o),
      url,
      title: t('b.edit')
    )
  end

  def link_to_delete(value)
    if value.is_a?(String)
      url = value
    else
      str = Udongo::ObjectPath.find(value)
      url = send(str, *Udongo::ObjectPath.remove_symbols(value))
    end

    link_to(
      icon(:trash),
      url,
      method: :delete,
      data: { confirm: t('b.msg.confirm') },
      title: t('b.delete')
    )
  end
end
