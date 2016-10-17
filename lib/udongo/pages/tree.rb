module Udongo::Pages
  class Tree
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def data(parent_id: nil)
      Page.where(parent_id: parent_id).inject([]) do |results, page|
        hash = Udongo::Pages::TreeNode.new(context, page).data
        hash[:children] = data(parent_id: page.id) if page.children.any?
        results << hash
      end
    end
  end
end
