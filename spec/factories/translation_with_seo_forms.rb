FactoryGirl.define do
  factory 'backend/translation_with_seo_form' do
    seo_slug 'foo'

    model { create(:page) }
    translation { model.translation(:nl) }
    seo { model.seo(:nl) }
    initialize_with { new(model, translation, seo) }
  end
end
