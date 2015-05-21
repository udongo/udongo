class PagePresenter < BasePresenter
  presents :page

  def options_for_parents(selected: nil, disabled: nil)
    list = Page.flat_tree.map do |p|
      ["#{'-' * p.depth} #{p.description}".strip, p.id]
    end

    options_for_select(list, selected: selected, disabled: disabled)
  end
end
