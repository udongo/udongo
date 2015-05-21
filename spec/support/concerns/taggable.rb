require 'rails_helper'

shared_examples_for :taggable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { create(klass) }

  it '#tags' do
    tag = create(:tag, locale: :nl, name: 'foo', slug: 'foo')
    instance.tagged_items.create!(tag: tag)
    expect(instance.tags).to eq [tag]
  end

  it '#tags_string' do
    tag1 = create(:tag, locale: :nl, name: 'foo', slug: 'foo')
    tag2 = create(:tag, locale: :nl, name: 'bar', slug: 'bar')
    instance.tagged_items.create!(tag: tag1)
    instance.tagged_items.create!(tag: tag2)
    expect(instance.tags_string).to eq 'foo,bar'
  end

  describe '#related' do
    let(:instance2) { create(klass) }
    let(:tag1) { create(:tag, locale: :nl, name: 'foo', slug: 'foo') }
    let(:tag2) { create(:tag, locale: :nl, name: 'bar', slug: 'bar') }

    it :blank do
      instance.tagged_items.create!(tag: tag1)
      instance2.tagged_items.create!(tag: tag2)
      expect(instance.related).to eq []
    end

    it :results do
      instance.tagged_items.create!(tag: tag1)
      instance.tagged_items.create!(tag: tag2)
      instance2.tagged_items.create!(tag: tag1)
      instance2.tagged_items.create!(tag: tag2)
      expect(instance.related).to eq [instance2]
      expect(instance2.related).to eq [instance]
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:tagged_items, :related, :tags, :tags_string)
  end
end

