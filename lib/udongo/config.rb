module Udongo
  class Config
    def initialize
      @configs = {}

      @allow_new_tags = true
      @flexible_content_types = %w(text image)
    end

    def method_missing(method_name, *arguments, &block)
      super if method_name.to_s.include?('=')

      unless @configs[method_name]
        @configs[method_name] = "Udongo::Configs::#{method_name.to_s.camelcase}".constantize.new
      end

      @configs[method_name]
    end

    def allow_new_tags?
      allow_new_tags === true
    end
  end
end
