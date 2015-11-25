module Udongo
  class MetaInfo
    attr_accessor :keywords, :description, :custom, :title

    def initialize(keywords: nil, description: nil, custom: nil, title: nil)
      @keywords = keywords
      @description = description
      @custom = custom
      @title = title
    end
  end
end
