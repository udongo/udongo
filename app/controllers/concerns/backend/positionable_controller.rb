module Concerns
  module Backend
    module PositionableController
      extend ActiveSupport::Concern

      def update_position
        find_model.set_list_position params[:position]
        head :ok
      end
    end
  end
end
