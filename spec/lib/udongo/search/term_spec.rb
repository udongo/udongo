require 'rails_helper'

describe Udongo::Search::Term do
  before(:each) do
    @synonym_a = create(:search_synonym, locale: 'nl', term: 'Dave', synonyms: 'developer')
    @synonym_b = create(:search_synonym, locale: 'nl', term: 'foobar', synonyms: 'blub,blubber,blubst')
    @synonym_c = create(:search_synonym, locale: 'nl', term: 'Zoeken', synonyms: "le search,c'est fou")
    @synonym_d = create(:search_synonym, locale: 'fr', term: 'Chercher', synonyms: "le search,c'est fou")
  end

  describe '#locale' do
    let(:instance) { described_class.new('foobar') }

    it 'defaults to Udongo.config.i18n.app.default_locale without controller input' do
      allow(Udongo.config.i18n.app).to receive(:default_locale) { 'jp' }
      expect(instance.locale).to eq :jp
    end

    it 'value passed from controller' do
      controller = OpenStruct.new(locale: :en)
      instance = described_class.new('foobar', controller: controller)
      expect(instance.locale).to eq :en
    end
  end

  describe '#synonym' do
    it 'nil' do
      instance = described_class.new('Unknown term')
      expect(instance.synonym).to be nil
    end

    it 'matches single synonym' do
      instance = described_class.new('developer')
      expect(instance.synonym).to eq @synonym_a
    end

    describe 'finds a match in a comma-separated list of 3 synonyms' do
      it 'matches on first' do
        instance = described_class.new('blub')
        expect(instance.synonym).to eq @synonym_b
      end

      it 'matches on second' do
        instance = described_class.new('blubber')
        expect(instance.synonym).to eq @synonym_b
      end

      it 'matches on third' do
        instance = described_class.new('blubst')
        expect(instance.synonym).to eq @synonym_b
      end
    end

    it 'matches locale' do
      controller = OpenStruct.new(locale: 'fr')
      instance = described_class.new('le search', controller: controller)

      expect(instance.synonym).to eq @synonym_d
    end
  end

  describe '#value' do
    it 'repeats incoming term without synonym match' do
      instance = described_class.new('Unknown term')
      expect(instance.value).to eq 'Unknown term'
    end

    it 'returns synonym term after synonym match' do
      instance = described_class.new('blubber')
      expect(instance.value).to eq 'foobar'
    end
  end

  it '#responds_to?' do
    expect(described_class.new('')).to respond_to(
      :locale, :synonym, :value
    )
  end
end
