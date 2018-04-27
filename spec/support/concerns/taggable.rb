require 'rails_helper'

shared_examples_for :taggable do
  let(:klass) { described_class.to_s.underscore.to_sym }
  subject { create(klass) }

  it '#tags' do
    tag = create(:tag, locale: :nl, name: 'foo', seo_slug: 'foo')
    subject.tagged_items.create!(tag: tag)
    expect(subject.tags(:nl)).to eq [tag]
  end

  it '#tags_string' do
    tag1 = create(:tag, locale: :nl, name: 'foo', seo_slug: 'foo')
    tag2 = create(:tag, locale: :nl, name: 'bar', seo_slug: 'bar')
    subject.tagged_items.create!(tag: tag1)
    subject.tagged_items.create!(tag: tag2)
    expect(subject.tags_string(:nl)).to eq 'foo,bar'
  end

  describe '#related' do
    let(:second) { create(klass) }
    let(:tag1) { create(:tag, locale: :nl, name: 'foo', seo_slug: 'foo') }
    let(:tag2) { create(:tag, locale: :nl, name: 'bar', seo_slug: 'bar') }

    it :blank do
      subject.tagged_items.create!(tag: tag1)
      second.tagged_items.create!(tag: tag2)
      expect(subject.related(:nl)).to eq []
    end

    it :results do
      subject.tagged_items.create!(tag: tag1)
      subject.tagged_items.create!(tag: tag2)
      second.tagged_items.create!(tag: tag1)
      second.tagged_items.create!(tag: tag2)
      expect(subject.related(:nl)).to eq [second]
      expect(second.related(:nl)).to eq [subject]
    end
  end

  it '#taggable?' do
    expect(subject).to be_taggable
  end

  it '#respond_to?' do
    expect(described_class.new).to respond_to(:tagged_items, :related, :tags, :tags_string, :taggable?)
  end
end

