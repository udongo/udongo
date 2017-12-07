require 'rails_helper'

describe Backend::TranslationWithSeoForm do
  let(:factory_name) { described_class.to_s.gsub('::', '/').underscore }
  subject { create(factory_name) }

  describe 'validations' do
    describe 'presence' do
      it(:seo_slug) { expect(build(factory_name, seo_slug: nil)).to_not be_valid }
      it(:seo_title) { expect(build(factory_name, seo_title: nil)).to_not be_valid }
      it(:seo_description) { expect(build(factory_name, seo_description: nil)).to_not be_valid }
    end
  end

  it '#seo_attributes' do
    expect(subject.seo_attributes).to eq %w(title keywords description custom_head slug)
  end

  it '#non_seo_attributes' do
    allow(subject).to receive(:attributes) { { foo: 'bar', bar: 'baz' } }
    expect(subject.non_seo_attributes).to eq [:foo, :bar]
  end

  it '#responds_to?' do
    expect(subject).to respond_to(:save, :persisted?)
  end
end
