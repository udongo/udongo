module Concerns
  module Backend
    module TranslatableController
      extend ActiveSupport::Concern

      included do
        before_action :find_models, only: [:edit_translation, :update_translation]
        helper_method :translatable_path
      end

      def update_translation
        if @translation.save(params[model_name])
          redirect_to translatable_path, notice: t('b.msg.changes_saved')
        else
          render :edit_translation
        end
      end

      private

      def find_models
        @model ||= find_model
        @translation = translation_form
      end

      def model_name
        @model.class.to_s.underscore.gsub('_decorator', '')
      end

      def set_translatable_path(path)
        @translatable_path ||= path
      end

      def translatable_path
        method = "edit_translation_backend_#{model_name}_path"
        @translatable_path || send(method, @model, params[:translation_locale])
      end
    end
  end
end
