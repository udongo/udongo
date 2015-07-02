class PageDecorator < Draper::Decorator
  delegate_all

  def options_for_parents(disabled: nil)
    list = ::Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end

    h.options_for_select(list, selected: parent_id, disabled: disabled)
  end
end
