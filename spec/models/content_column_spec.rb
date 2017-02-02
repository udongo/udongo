require 'rails_helper'

describe ContentColumn do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'after_destroy' do
    let(:content) { create(:content_text, content: 'foobar') }
    let(:instance) { create(klass, content: content) }
    let(:page) do
      # Necessary to exclude the otherwise mandatory Page#description
      # to be included in the search indices for these tests.
      allow(Page).to receive(:searchable_fields_list) { [:flexible_content] }
      create(:page)
    end

    it 'no errors without searchable parent link' do
      expect { instance.destroy }.to_not raise_error
    end

    it 'removes search indices from searchable parent' do
      create(:content_row, columns: [instance], rowable: page)
      index = create(:search_index, searchable: page, name: "flexible_content:#{content.id}")
      expect(instance.parent.search_indices).to eq [index]
      instance.destroy
      expect(instance.parent.search_indices).to eq []
    end
  end

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

  describe 'searchable integration' do
    let(:instance) { create(klass) }

    describe 'linked_to_searchable_parent?' do
      let(:page) { create(:page) }

      it 'true' do
        create(:content_row, columns: [instance], rowable: page)
        expect(instance.linked_to_searchable_parent?).to be true
      end

      describe 'false' do
        it 'no parent' do
          create(:content_row, columns: [instance])
          expect(instance.linked_to_searchable_parent?).to be false
        end

        it 'parent not searchable' do
          create(:content_row, columns: [instance], rowable: page)
          allow_any_instance_of(Page).to receive(:searchable?) { false }
          expect(instance.linked_to_searchable_parent?).to be false
        end
      end
    end
  end

  it '#parent' do
    instance = create(klass)
    page = create(:page)
    create(:content_row, columns: [instance], rowable: page)
    expect(instance.parent).to eq page
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(
      :row, :content, :parent, :linked_to_searchable_parent?
    )
  end
end
