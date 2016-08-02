require 'rails_helper'

describe Backend::PageTranslationForm do
  let(:klass) { described_class }
  let(:valid_params) do
    {
      title: 'foo',
      seo_slug: 'bar'
    }
  end
  let(:page) { create(:page) }
  let(:instance) { klass.new(page, page.translation, page.seo) }

  describe 'validations' do
    describe 'presence' do
      it :title do
        params = valid_params.merge(title: nil)
        expect(instance.save(params)).to eq false
      end
    end
  end

  it '#save' do
    page = create(:page)

    expect(klass.new(page, page.translation(:nl), page.seo(:nl)).save(
      title: 'foo',
      subtitle: 'bar',
      seo_title: 'baz',
      seo_keywords: 'foo',
      seo_description: 'bar',
      seo_custom: 'baz',
      seo_slug: 'foo'
    )).to eq true

    translation = Page.first.translation(:nl)
    expect(translation.title).to eq 'foo'
    expect(translation.subtitle).to eq 'bar'

    seo = Page.first.seo(:nl)
    expect(seo.title).to eq 'baz'
    expect(seo.keywords).to eq 'foo'
    expect(seo.description).to eq 'bar'
    expect(seo.custom).to eq 'baz'
    expect(seo.slug).to eq 'foo'
  end

  it '#persisted?' do
    expect(instance).to be_persisted
  end

  it '#respond_to' do
    expect(instance).to respond_to(:save, :persisted?, :page, :translation, :seo)
  end
end
