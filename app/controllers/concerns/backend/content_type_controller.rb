module Concerns
  module Backend
    module ContentTypeController
      extend ActiveSupport::Concern

      included do
        layout 'backend/lightbox'
        before_action :find_model
      end

      module ClassMethods
        def model(value)
          define_method(:model) { value }
        end

        def allowed_params(*args)
          define_method(:allowed_params) do
            params.require(model.name.tableize.singularize).permit(*args)
          end
        end
      end

      def find_model
        @model = model.find(params[:id]).decorate
      end

      def update
        if @model.update_attributes allowed_params
          render 'backend/lightbox_saved'
        else
          render :edit
        end
      end
    end
  end
end
