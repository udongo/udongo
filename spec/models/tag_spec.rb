require 'rails_helper'

describe Tag do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
      it(:seo_slug) { expect(build(klass, seo_slug: nil)).not_to be_valid }
    end

    it :unique do
      create(klass, seo_slug: 'foo', locale: 'nl')
      expect(build(klass, seo_slug: 'FOO', locale: 'nl')).not_to be_valid
    end
  end

  it '#respond_to?' do
    expect(subject).to respond_to(:tagged_items)
  end
end

