module LinkHelper
  def link_to_show(object)
    str = find_object_path(object)

    link_to(
      icon(:search),
      send(str, *remove_symbols(object)),
      title: t('b.view')
    )
  end

  def link_to_edit(object)
    str = "edit_#{find_object_path(object)}"

    link_to(
      icon(:pencil_square_o),
      send(str, *remove_symbols(object)),
      title: t('b.edit')
    )
  end

  def link_to_delete(object)
    str = find_object_path(object)

    link_to(
      icon(:trash),
      send(str, *remove_symbols(object)),
      method: :delete,
      data: { confirm: t('b.msg.confirm') },
      title: t('b.delete')
    )
  end

  def find_object_path(object)
    return "#{object.class.name.underscore}_path" unless object.is_a?(Array)

    object.map do |item|
      if item.is_a?(Symbol)
        "#{item}"
      else
        "#{item.class.name.underscore}"
      end
    end.join('_') << '_path'
  end

  def remove_symbols(object)
    return object unless object.is_a?(Array)
    object.select { |o| !o.is_a?(Symbol) }
  end
end
