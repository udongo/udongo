require 'rails_helper'

describe ContentText do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :content_type

  describe 'after_save' do
    # This is tested through spec/support/concerns/searchable.rb
  end

  describe 'searchable integration' do
    let(:instance) { create(klass) }

    describe 'linked_to_searchable_parent?' do
      let(:page) { create(:page) }
      let(:column) { create(:content_column, content: instance) }

      it 'true' do
        create(:content_row, columns: [column], rowable: page)
        expect(instance.linked_to_searchable_parent?).to be true
      end

      describe 'false' do
        it 'no column' do
          expect(instance.linked_to_searchable_parent?).to be false
        end

        it 'no parent' do
          create(:content_row, columns: [column])
          expect(instance.linked_to_searchable_parent?).to be false
        end

        it 'parent not searchable' do
          create(:content_row, columns: [column], rowable: page)
          allow_any_instance_of(Page).to receive(:searchable?) { false }
          expect(instance.linked_to_searchable_parent?).to be false
        end
      end
    end
  end

  it '#content_type' do
    expect(build(klass).content_type).to eq :text
  end

  it '#column' do
    instance = create(klass)
    column = create(:content_column, content: instance)
    expect(instance.column).to eq column
  end

  it '#parent' do
    instance = create(klass)
    page = create(:page)
    column = create(:content_column, content: instance)
    create(:content_row, columns: [column], rowable: page)
    expect(instance.parent).to eq page
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(
      :content_type, :column, :parent, :linked_to_searchable_parent?
    )
  end
end
