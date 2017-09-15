require 'rails_helper'

shared_examples_for :seo do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { create(klass) }

  describe '#seo_locales' do
    it 'defaults to an empty array' do
      expect(build(klass).seo_locales.class).to eq Array
    end

    it 'updates when a slug is present' do
      object = create(klass)
      object.seo(:nl).slug = 'foo'
      object.save

      expect(object.seo_locales).to include 'nl'
    end

    it 'does not update unless a slug is present' do
      object = create(klass)
      object.seo(:nl).slug = nil
      object.save

      expect(object.seo_locales).to eq []
    end
  end

  describe '#seo' do
    it 'always returns a meta object' do
      expect(instance.seo(:nl).class).to eq Meta
    end

    describe 'fetch locale specific meta object' do
      it 'new' do
        instance.seo(:nl) == instance.seo(:nl)
      end

      it 'saved' do
        meta = instance.meta.create(locale: 'nl', slug: 'test')
        expect(instance.seo(:nl)).to eq meta
      end
    end
  end

  describe 'scopes' do
    describe '.with_seo' do
      it 'no results' do
        expect(model.with_seo(:nl)).to eq []
      end

      it 'dutch only' do
        object = create(klass)
        object.seo(:nl).slug = 'foo'
        object.save

        expect(model.with_seo(:nl)).to eq [object]
      end

      it 'dutch and english' do
        object = create(klass)
        object.seo(:nl).slug = 'foo'
        object.seo(:en).slug = 'foo'
        object.save

        expect(model.with_seo(:nl)).to eq [object]
      end
    end
  end

  describe '.find_by_slug' do
    it :result do
      instance.meta.create!(locale: 'nl', slug: 'test')
      expect(model.find_by_slug('test', locale: :nl)).to eq instance
    end

    it 'no result' do
      expect(model.find_by_slug('test', locale: :nl)).to eq nil
    end
  end

  describe '.find_by_slug!' do
    it :result do
      instance.meta.create!(locale: 'nl', slug: 'test')
      expect(model.find_by_slug!('test', locale: :nl)).to eq instance
    end

    it 'no result' do
      expect{ model.find_by_slug!('test', locale: :nl) }.to raise_exception RuntimeError
    end
  end

  it 'autosave when the parent is saved' do
    instance.seo(:en).title = 'some foo'
    instance.save

    expect(model.find(instance.id).seo(:en).title).to eq 'some foo'
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:meta, :seo)
  end

  it '.respond_to?' do
    expect(model).to respond_to(:find_by_slug, :find_by_slug!, :with_seo)
  end
end
