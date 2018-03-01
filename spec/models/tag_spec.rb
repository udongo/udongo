require 'rails_helper'

describe Tag do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :locale
  it_behaves_like :seo
  it_behaves_like :translatable

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
      it(:slug) { expect(build(klass, slug: nil)).not_to be_valid }
    end

    it :unique do
      create(klass, slug: 'foo', locale: 'nl')
      expect(build(klass, slug: 'FOO', locale: 'nl')).not_to be_valid
    end
  end

  it 'translatable' do
    expect(described_class.translatable_fields_list).to eq [:summary]
  end

  it '#respond_to?' do
    expect(subject).to respond_to(:tagged_items)
  end
end

