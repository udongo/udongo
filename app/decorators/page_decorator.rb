class PageDecorator < Draper::Decorator
  delegate_all

  # TODO is this selected: nil still needed?
  def options_for_parents(selected: nil, disabled: nil)
    list = Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end

    h.options_for_select(list, selected: selected, disabled: disabled)
  end
end
