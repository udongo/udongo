require 'rails_helper'

describe SearchTerm do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:term) { expect(build(klass, term: nil)).to_not be_valid }
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
    end
  end
end
