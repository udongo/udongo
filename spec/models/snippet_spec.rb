require 'rails_helper'

describe Snippet do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :translatable
  it_behaves_like :cacheable

  describe 'validations' do
    describe 'presence' do
      it(:identifier) { expect(build(klass, identifier: nil)).not_to be_valid }
      it(:description) { expect(build(klass, description: nil)).not_to be_valid }
    end

    describe 'identifier' do
      it :unique do
        create(klass, identifier: 'foo')
        expect(build(klass, identifier: 'FOO')).not_to be_valid
      end
    end
  end

  it 'translatable' do
    expect(model.translation_config.fields).to eq [:title, :content]
  end
end
