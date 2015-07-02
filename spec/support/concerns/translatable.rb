require 'rails_helper'

shared_examples_for :translatable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe '#locales' do
    it 'defaults to an empty array' do
      expect(build(klass).locales.class).to eq Array
    end

    it 'updates when a translation is added' do
      object = create(klass)
      field = model.translation_config.fields.first
      object.translation(:nl).send("#{field}=", 'foo')
      object.translation(:nl).save

      expect(object.locales).to eq ['nl']
    end
  end

  describe 'scopes' do
    describe '.within_locale' do
      it 'no results' do
        expect(model.within_locale(:nl)).to eq []
      end

      it 'dutch only' do
        object = create(klass, locales: %w(nl))
        expect(model.within_locale(:nl)).to eq [object]
      end

      it 'dutch and english' do
        object = create(klass, locales: %w(nl en))
        expect(model.within_locale(:nl)).to eq [object]
      end
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:translation)
  end

  it '.respond_to?' do
    expect(model).to respond_to(
      :translatable_field, :translatable_fields, :translation_config,
      :within_locale
    )
  end
end
