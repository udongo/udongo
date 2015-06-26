require 'rails_helper'
require "#{Udongo::PATH}/spec/support/concerns/sortable"

describe ContentRow do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
      it(:rowable_type) { expect(build(klass, rowable_type: nil)).to_not be_valid }
      it(:rowable_id) { expect(build(klass, rowable_id: nil)).to_not be_valid }
    end
  end

  describe 'scopes' do
    it '.by_locale' do
      a = create(klass, locale: 'nl')
      b = create(klass, locale: 'fr')
      c = create(klass, locale: 'en')

      expect(model.by_locale(:nl)).to eq [a]
      expect(model.by_locale(%w(nl fr))).to eq [a, b]
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:rowable, :columns)
  end

  it '.respond_to?' do
    expect(model).to respond_to(:by_locale)
  end
end
