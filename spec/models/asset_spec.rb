require 'rails_helper'

describe Asset do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :taggable

  describe 'validations' do
    describe 'presence' do
      it(:filename) { expect(build(klass, filename: nil)).not_to be_valid }
    end
  end

  describe '#image?' do
    it :true do
      %w(gif jpeg jpg png).each do |ext|
        asset = build(klass, content_type: "image/#{ext}")
        expect(asset).to be_image
      end
    end

    it :false do
      asset = build(klass, content_type: 'application/pdf')
      expect(asset).not_to be_image
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:image?)
  end
end

