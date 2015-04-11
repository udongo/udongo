# If you want to use this concern, you need to add an integer field 'parent_id'
# to the model.
module Concerns
  module Parentable
    extend ActiveSupport::Concern

    included do
      has_many :children, class_name: self.name, foreign_key: :parent_id, dependent: :destroy
      belongs_to :parent, class_name: self.name
    end

    def depth
      parent.nil? ? 0 : 1 + parent.depth
    end

    def parentable?
      true
    end

    module ClassMethods
      def flat_tree(parent_id: nil, list: [])
        children = name.constantize.where(parent_id: parent_id)

        children.each do |p|
          list << p
          list = self.flat_tree(parent_id: p.id, list: list) if p.children.any?
        end

        list
      end
    end
  end
end
