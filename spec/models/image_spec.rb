require 'rails_helper'

describe Image do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :visible
  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:asset) { expect(build(klass, asset: nil)).not_to be_valid }
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:asset, :imageable)
  end
end

