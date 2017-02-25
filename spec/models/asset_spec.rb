require 'rails_helper'

describe Asset do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :taggable

  describe 'validations' do
    describe 'presence' do
      it(:filename) { expect(build(klass, filename: nil)).not_to be_valid }
    end
  end

  it '#responds_to?' do
    # expect(build(klass)).to respond_to(:foo)
  end
end

