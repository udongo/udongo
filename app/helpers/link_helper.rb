module LinkHelper
  def link_to_show(object)
    str = Udongo::ObjectPath.find(object)

    link_to(
      icon(:search),
      send(str, *Udongo::ObjectPath.remove_symbols(object)),
      title: t('b.view')
    )
  end

  def link_to_edit(object)
    str = "edit_#{Udongo::ObjectPath.find(object)}"

    link_to(
      icon(:pencil_square_o),
      send(str, *Udongo::ObjectPath.remove_symbols(object)),
      title: t('b.edit')
    )
  end

  def link_to_delete(object)
    str = Udongo::ObjectPath.find(object)

    link_to(
      icon(:trash),
      send(str, *Udongo::ObjectPath.remove_symbols(object)),
      method: :delete,
      data: { confirm: t('b.msg.confirm') },
      title: t('b.delete')
    )
  end
end
