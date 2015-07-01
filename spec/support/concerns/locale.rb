require 'rails_helper'

shared_examples_for :locale do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'scopes' do
    it '.by_locale' do
      a = create(klass, locale: 'nl')
      b = create(klass, locale: 'fr')
      c = create(klass, locale: 'en')

      expect(model.by_locale(:nl)).to eq [a]
      expect(model.by_locale(%w(nl fr))).to eq [a, b]
    end
  end

  it '.respond_to?' do
    expect(model).to respond_to(:by_locale)
  end
end
