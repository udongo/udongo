require 'rails_helper'

shared_examples_for :seo do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { create(klass) }

  describe '#seo' do
    it 'always returns a meta object' do
      expect(instance.seo(:nl).class).to eq Meta
      pending
    end

    it 'fetch locale specific meta object' do
      meta = instance.meta.create(locale: 'nl', slug: 'test')
      expect(instance.seo(:nl)).to eq meta
      pending
    end
  end

  describe '.find_by_slug' do
    it :result do
      instance.meta.create(locale: 'nl', slug: 'test')
      expect(model.find_by_slug('test', locale: :nl)).to eq instance
      pending
    end

    it 'no result' do
      expect(model.find_by_slug('test', locale: :nl)).to eq nil
      pending
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:meta, :seo)
    pending
  end

  it '.respond_to?' do
    expect(model).to respond_to(:find_by_slug)
    pending
  end
end
