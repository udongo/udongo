module Backend
  module PaginationHelper
    def udongo_paginate(collection, options = {})
      will_paginate(collection, Udongo::WillPaginate::Options.new(options).values)
    end
  end
end
