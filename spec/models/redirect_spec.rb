require 'rails_helper'

describe Redirect do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:source_uri) { expect(build(klass, source_uri: nil)).to_not be_valid }
      it(:destination_uri) { expect(build(klass, destination_uri: nil)).to_not be_valid }
      it(:status_code) { expect(build(klass, status_code: nil)).to_not be_valid }
    end

    describe 'uniqueness' do
      it(:source_uri) do
        create(klass, source_uri: 'foo')
        expect(build(klass, source_uri: 'FOo')).to_not be_valid
      end
    end
  end
end
