require 'rails_helper'

describe Udongo::Search::Term do
  before(:each) do
    @synonym_a = create(:search_synonym, locale: 'nl', term: 'Dave', synonyms: 'developer')
    @synonym_b = create(:search_synonym, locale: 'nl', term: 'foobar', synonyms: 'blub,blubber,blubst')
    @synonym_c = create(:search_synonym, locale: 'nl', term: 'Zoeken', synonyms: "le search,c'est fou")
    @synonym_d = create(:search_synonym, locale: 'fr', term: 'Chercher', synonyms: "le search,c'est fou")
  end

  describe '#locale' do
    subject { described_class.new('foobar') }

    it 'defaults to Udongo.config.i18n.app.default_locale without controller input' do
      allow(Udongo.config.i18n.app).to receive(:default_locale) { 'jp' }
      expect(subject.locale).to eq :jp
    end

    it 'value passed from controller' do
      controller = OpenStruct.new(locale: :en)
      subject = described_class.new('foobar', controller: controller)
      expect(subject.locale).to eq :en
    end
  end

  describe '#synonym' do
    it 'nil' do
      subject = described_class.new('Unknown term')
      expect(subject.synonym).to be nil
    end

    it 'matches single synonym' do
      subject = described_class.new('developer')
      expect(subject.synonym).to eq @synonym_a
    end

    describe 'finds a match in a comma-separated list of 3 synonyms' do
      it 'matches on first' do
        subject = described_class.new('blub')
        expect(subject.synonym).to eq @synonym_b
      end

      it 'matches on second' do
        subject = described_class.new('blubber')
        expect(subject.synonym).to eq @synonym_b
      end

      it 'matches on third' do
        subject = described_class.new('blubst')
        expect(subject.synonym).to eq @synonym_b
      end
    end

    it 'matches locale' do
      controller = OpenStruct.new(locale: 'fr')
      subject = described_class.new('le search', controller: controller)

      expect(subject.synonym).to eq @synonym_d
    end
  end

  describe '#value' do
    it 'repeats incoming term without synonym match' do
      subject = described_class.new('Unknown term')
      expect(subject.value).to eq 'Unknown term'
    end

    it 'returns synonym term after synonym match' do
      subject = described_class.new('blubber')
      expect(subject.value).to eq 'foobar'
    end
  end

  describe '#valid?' do
    it 'returns false when the term is nil' do
      subject = described_class.new(nil)
      expect(subject.valid?).to be false
    end

    it 'returns false when the term is an empty string' do
      subject = described_class.new('')
      expect(subject.valid?).to be false
    end

    it 'returns true when the term has a value' do
      subject = described_class.new('foo')
      expect(subject.valid?).to be true
    end
  end

  it '#responds_to?' do
    expect(described_class.new('')).to respond_to(
      :locale, :synonym, :value
    )
  end
end
