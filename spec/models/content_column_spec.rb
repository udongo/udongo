require 'rails_helper'

describe ContentColumn do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:row) { expect(build(klass, row: nil)).not_to be_valid }
    end

    describe 'width' do
      it(:presence) { expect(build(klass, width: nil)).not_to be_valid }

      it '1..12' do
        [-1, 0, 1.1].each do |i|
          expect(build(klass, width: i)).not_to be_valid
        end

        (1..12).each do |i|
          expect(build(klass, width: i)).to be_valid
        end
      end
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:row, :content)
  end
end
