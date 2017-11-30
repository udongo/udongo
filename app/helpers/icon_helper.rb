module IconHelper
  # I wanted to make a named param out of label, though this would imply a
  # backwards incompatible change that would require a non-trivial amount of
  # editing.
  #
  # If you want to take this along with the next planned major release, you can
  # use the following CMD in bash (assuming you have silver searcher installed)
  # to get a list of all icon calls that pass anything more than just a name.
  #
  #   ag 'icon\((:|")(\w+), '
  #
  def icon(name, lbl = nil)
    markup = content_tag :i, nil, class: "fa fa-#{name.to_s.tr('_', '-')}"
    lbl ? "#{markup}&nbsp;#{lbl}".html_safe : markup
  end
end
