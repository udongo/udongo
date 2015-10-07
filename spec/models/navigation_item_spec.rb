require 'rails_helper'

describe NavigationItem do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :translatable
  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:navigation) { expect(build(klass, navigation: nil)).not_to be_valid }
    end
  end

  it 'translatable' do
    expect(model.translation_config.fields).to eq [:title, :path]
  end
end

