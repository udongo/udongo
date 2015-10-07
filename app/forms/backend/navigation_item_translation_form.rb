class Backend::NavigationItemTranslationForm < Reform::Form
  include Composition

  model :navigation_item

  property :title, on: :translation
  property :path, on: :translation
end
