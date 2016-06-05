module Concerns
  module Backend
    module ContentTypeController
      extend ActiveSupport::Concern

      included do
        layout 'backend/lightbox'
        before_action :find_model
        helper_method :content_path
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

      def content_path
        column = @model.column
        path = "edit_translation_backend_#{column.row.rowable.class.to_s.downcase}_path"
        send(path, column.row.rowable, locale, anchor: "content-row-#{column.row.id}")
      end

      def update
        if @model.update_attributes allowed_params
          redirect_to content_path
        else
          render :edit
        end
      end
    end
  end
end
