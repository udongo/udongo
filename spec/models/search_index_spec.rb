require 'rails_helper'

describe SearchIndex do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
      it(:searchable) { expect(build(klass, searchable: nil)).to_not be_valid }
      it(:key) { expect(build(klass, key: nil)).to_not be_valid }
      it(:value) { expect(build(klass, value: nil)).to_not be_valid }
    end
  end

  it '#respond_to?' do
    expect(described_class.new).to respond_to(:searchable)
  end
end
