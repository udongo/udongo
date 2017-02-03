require 'rails_helper'

describe SearchSynonym do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
      it(:term) { expect(build(klass, term: nil)).to_not be_valid }
      it(:synonyms) { expect(build(klass, synonyms: nil)).to_not be_valid }
    end

    describe 'uniqueness' do
      it :term do
        create(klass, term: 'foo', locale: 'nl')
        expect(build(klass, term: 'FOO', locale: 'nl')).not_to be_valid
      end
    end
  end
end
