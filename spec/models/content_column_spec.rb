require 'rails_helper'

describe ContentColumn do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:row) { expect(build(klass, row: nil)).not_to be_valid }
      it(:width) { expect(build(klass, width: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:row, :content)
  end
end
