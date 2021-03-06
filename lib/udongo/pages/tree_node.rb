module Udongo::Pages
  class TreeNode
    # Context should contain accessible routes.
    def initialize(context, page)
      @context = context
      @page = page
    end

    def data
      {
        text: @page.description,
        type: :file,
        li_attr: list_attributes,
        data: {
          id: @page.id,
          url: @context.edit_translation_backend_page_path(@page, Udongo.config.i18n.app.default_locale),
          delete_url: @context.backend_page_path(@page, format: :json),
          deletable: @page.deletable?,
          draggable: @page.draggable?,
          update_position_url: @context.tree_drag_and_drop_backend_page_path(@page),
          visible: @page.visible?,
          toggle_visibility_url: @context.toggle_visibility_backend_page_path(@page, format: :json)
        },
        children: [] # This gets filled through Udongo::Pages::Tree
      }
    end

    def list_attributes
      return if @page.visible?

      {
        class: 'jstree-node-invisible',
        title: I18n.t('b.msg.pages.invisible')
      }
    end

    def state
      {
        selected: false
      }
    end
  end
end
