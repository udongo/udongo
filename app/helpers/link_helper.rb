module LinkHelper
  def link_to_show(object)
    str = find_object_path(object)
    link_to icon(:search), send(str, *remove_symbols(object))
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

  private

  def find_object_path(object)
    str = ''

    if object.is_a?(Array)

      object.each do |item|
        if item.is_a?(Symbol)
          str << "#{item}_"
        else
          str << "#{item.class.name.underscore}_"
        end
      end
    else
      str << "#{object.class.name.underscore}_"
    end

    str << 'path'
    str
  end

  def remove_symbols(object)
    if object.is_a?(Array)
      object.select { |o| !o.is_a?(Symbol) }
    else
      object
    end
  end
end
