require 'rails_helper'

describe Backend::PageTranslationForm do
  let(:valid_params) do
    {
      title: 'Dit is een titel',
      seo_slug: 'dit-is-een-titel'
    }
  end
  let(:page) { create(:page) }
  let(:instance) { described_class.new(page, page.translation, page.seo) }

  describe 'validations' do
    describe 'presence' do
      it :title do
        valid_params[:title] = nil
        expect(instance.save(valid_params)).to eq false
      end
    end
  end

  describe '#save' do
    let(:page) { create(:page) }
    let(:instance) do
      described_class.new(page, page.translation(:nl), page.seo(:nl))
    end

    describe 'translations' do
      before(:each) do
        valid_params.reverse_merge!(subtitle: 'Dit is een subtitel')
        instance.save(valid_params)
        @translation = Page.first.translation(:nl)
      end

      it 'title' do
        expect(@translation.title).to eq 'Dit is een titel'
      end

      it 'subtitle' do
        expect(@translation.subtitle).to eq 'Dit is een subtitel'
      end
    end

    describe 'seo' do
      before(:each) do
        valid_params.reverse_merge!(
          seo_title: 'Dit is een titel',
          seo_keywords: 'titels,taal,nederlands',
          seo_description: 'Dit is een SEO beschrijving',
          seo_custom: 'Dit is de inhoud v/e custom meta veld',
        )
        instance.save(valid_params)
        @seo = Page.first.seo(:nl)
      end

      it 'seo_title' do
        expect(@seo.title).to eq 'Dit is een titel'
      end

      it 'seo_keywords' do
        expect(@seo.keywords).to eq 'titels,taal,nederlands'
      end

      it 'seo_description' do
        expect(@seo.description).to eq 'Dit is een SEO beschrijving'
      end

      it 'seo_custom' do
        expect(@seo.custom).to eq 'Dit is de inhoud v/e custom meta veld'
      end

      it 'seo_slug' do
        expect(@seo.slug).to eq 'dit-is-een-titel'
      end
    end
  end

  it '#persisted?' do
    expect(instance).to be_persisted
  end
end
