require 'rails_helper'

describe NavigationItem do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:page) { expect(build(klass, page: nil)).to_not be_valid }
      it(:list) { expect(build(klass, list: nil)).to_not be_valid }
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:list)
  end
end
