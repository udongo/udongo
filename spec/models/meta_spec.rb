require 'rails_helper'

describe Meta do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:slug) { expect(build(klass, slug: nil)).to_not be_valid }
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
    end

    it 'unique slug' do
      create(klass, slug: 'foo', sluggable_type: 'Bar')
      expect(build(klass, slug: 'FOO', sluggable_type: 'BAR')).to_not be_valid
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:sluggable)
  end
end

