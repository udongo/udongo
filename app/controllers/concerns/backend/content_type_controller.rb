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

      # TODO we no longer need this
      def content_path
        column = @model.column
        path = "edit_translation_backend_#{column.row.rowable.class.to_s.downcase}_path"
        # TODO this needs to be the locale that you were editing, not the interface locale.
        # You can reproduce this by editing flexible content in NL when your interface is english.
        send(path, column.row.rowable, @model.column.row.locale, anchor: "content-row-#{column.row.id}")
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
