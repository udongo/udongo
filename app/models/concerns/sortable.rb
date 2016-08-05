# If you want to use this concern, you need to add an integer field 'position'
# to the model.
module Concerns
  module Sortable
    extend ActiveSupport::Concern

    included do
      acts_as_list
      default_scope ->{ order(:position) }
    end

    module ClassMethods
      def sortable(*args)
        acts_as_list *args
      end
    end

    # TODO (Dave) - https://github.com/udongo/udongo/issues/20
    def set_position(new_position, parent_id = nil)
      if respond_to?(:draggable?) && !draggable? || position == new_position.to_i
        return false
      end

      if respond_to?(:parentable?) && parentable?
        update_attribute :parent_id, parent_id
      end

      set_list_position new_position
    end
  end
end
