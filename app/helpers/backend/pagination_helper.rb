module Backend
  module PaginationHelper

    def udongo_paginate(collection, options = {})
      options.merge!(
        class: 'pagination',
        inner_window: 1,
        outer_window: 0,
        renderer: Udongo::WillPaginate::Renderer,
        previous_label: '&lt;'.html_safe,
        next_label: '&gt;'.html_safe
      )

      will_paginate collection, options
    end
  end
end
