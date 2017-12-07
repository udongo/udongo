require 'rails_helper'

describe Meta do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(described_class.new).to respond_to(
      :sluggable, :seo_title, :seo_keywords, :seo_description, :seo_custom_head,
      :seo_slug, :seo_custom
    )
  end
end

