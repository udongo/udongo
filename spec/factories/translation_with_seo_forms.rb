FactoryGirl.define do
  factory 'backend/translation_with_seo_form' do
    seo_slug 'foo'
    seo_title 'Foo'
    seo_description 'This is a foo'

    model { create(:page) }
    translation { model.translation(:nl) }
    seo { model.seo(:nl) }
    initialize_with { new(model, translation, seo) }
  end
end
