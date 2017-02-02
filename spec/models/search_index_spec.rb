require 'rails_helper'

describe SearchIndex do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).to_not be_valid }
      it(:name) { expect(build(klass, name: nil)).to_not be_valid }
    end
  end

  it '#respond_to?' do
    expect(described_class.new).to respond_to(:searchable)
  end
end
