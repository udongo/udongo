require 'rails_helper'

describe ContentColumn do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:row) { expect(build(klass, row: nil)).not_to be_valid }
      it(:width_xs) { expect(build(klass, width_xs: nil)).not_to be_valid }
      it(:width_sm) { expect(build(klass, width_sm: nil)).not_to be_valid }
      it(:width_md) { expect(build(klass, width_md: nil)).not_to be_valid }
      it(:width_lg) { expect(build(klass, width_lg: nil)).not_to be_valid }
      it(:width_xl) { expect(build(klass, width_xl: nil)).not_to be_valid }
    end

    describe 'width' do
      describe 'xs' do
        it '1..12' do
          [-1, 0, 1.1].each do |i|
            expect(build(klass, width_xs: i)).not_to be_valid
          end

          (1..12).each do |i|
            expect(build(klass, width_xs: i)).to be_valid
          end
        end
      end

      describe 'sm' do
        it '1..12' do
          [-1, 0, 1.1].each do |i|
            expect(build(klass, width_sm: i)).not_to be_valid
          end

          (1..12).each do |i|
            expect(build(klass, width_sm: i)).to be_valid
          end
        end
      end

      describe 'md' do
        it '1..12' do
          [-1, 0, 1.1].each do |i|
            expect(build(klass, width_md: i)).not_to be_valid
          end

          (1..12).each do |i|
            expect(build(klass, width_md: i)).to be_valid
          end
        end
      end

      describe 'lg' do
        it '1..12' do
          [-1, 0, 1.1].each do |i|
            expect(build(klass, width_lg: i)).not_to be_valid
          end

          (1..12).each do |i|
            expect(build(klass, width_lg: i)).to be_valid
          end
        end
      end

      describe 'xl' do
        it '1..12' do
          [-1, 0, 1.1].each do |i|
            expect(build(klass, width_xl: i)).not_to be_valid
          end

          (1..12).each do |i|
            expect(build(klass, width_xl: i)).to be_valid
          end
        end
      end
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:row, :content)
  end
end
