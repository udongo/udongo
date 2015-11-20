require 'rails_helper'

describe TaggedItem do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:tag) { expect(build(klass, tag: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:taggable, :tag)
  end
end

