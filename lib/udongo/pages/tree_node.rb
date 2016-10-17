module Udongo::Pages
  class TreeNode
    attr_reader :context, :page

    # Context should contain accessible routes.
    def initialize(context, page)
      @context = context
      @page = page
    end

    def data
      {
        text: page.description,
        type: :file,
        li_attr: list_attributes,
        data: {
          id: page.id,
          url: context.edit_backend_page_path(page),
          delete_url: context.backend_page_path(page, format: :json),
          deletable: page.deletable?,
          draggable: page.draggable?,
          update_position_url: context.tree_drag_and_drop_backend_page_path(page)
        },
        children: [] # This gets filled through Udongo::Pages::Tree
      }
    end

    def list_attributes
      return if page.visible?

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
