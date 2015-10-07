class Backend::NavigationItemTranslationForm < Reform::Form
  include Composition

  model :navigation_item

  property :label, on: :translation
  property :path, on: :translation
end
