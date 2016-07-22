module Udongo
  module Configs
    class Base
      include Virtus.model

      attribute :host, String, default: 'udongo.dev'
      attribute :project_name, String, default: 'Udongo'
      attribute :time_zone, String, default: 'Brussels'
    end
  end
end
