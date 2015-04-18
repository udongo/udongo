require 'rails_helper'

describe Translation do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
    end

    it 'unique name scoped on translatable_type, translatable_id and locale' do
      create(klass, translatable_type: 'Article', translatable_id: 1, locale: 'nl', name: 'foo')
      expect(build(klass, translatable_type: 'Article', translatable_id: 1, locale: 'nl', name: 'FOO')).not_to be_valid
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:translatable)
  end
end

