require 'rails_helper'

describe Page do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :translatable
  it_behaves_like :taggable
  it_behaves_like :parentable
  it_behaves_like :visible
  it_behaves_like :seo
  it_behaves_like :deletable
  it_behaves_like :sortable
  it_behaves_like :draggable
  it_behaves_like :flexible_content
  it_behaves_like :cacheable
  it_behaves_like :searchable

  describe 'validations' do
    describe 'presence' do
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
    expect(model.translatable_fields_list).to eq [:title, :subtitle]
  end

  it 'searchable fields' do
    expect(model.searchable_fields_list).to eq [:title, :subtitle, :content]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:navigation_items)
  end
end
