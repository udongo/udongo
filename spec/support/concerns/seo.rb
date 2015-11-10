require 'rails_helper'

shared_examples_for :seo do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { create(klass) }

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

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:meta, :seo)
  end

  it '.respond_to?' do
    expect(model).to respond_to(:find_by_slug, :find_by_slug!)
  end
end
