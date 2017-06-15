require 'rails_helper'

describe ImageCollection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :cacheable
  it_behaves_like :imageable

  describe 'validations' do
    describe 'presence' do
      it(:description) { expect(build(klass, description: nil)).not_to be_valid }
    end

    describe 'identifier' do
      it :unique do
        create(klass, identifier: 'foo')
        expect(build(klass, identifier: 'FOO')).not_to be_valid
      end
    end
  end
end
