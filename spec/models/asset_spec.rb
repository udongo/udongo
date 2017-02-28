require 'rails_helper'

describe Asset do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :taggable

  describe 'validations' do
    describe 'presence' do
      it(:filename) { expect(build(klass, filename: nil)).not_to be_valid }
    end
  end

  describe 'before_save' do
    it 'update the filesize' do
      asset = build(klass)
      expect(asset.filesize).to eq nil

      asset.save!
      expect(asset.filesize).to eq 45014
    end

    it 'update the content_type' do
      asset = build(klass)
      expect(asset.content_type).to eq nil

      asset.save!
      expect(asset.content_type).to eq 'application/jpeg'
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

  describe '#image' do
    it :nil do
      asset = create(klass, content_type: 'application/pdf')
      expect(asset.image).to eq nil
    end

    it 'AssetImage' do
      asset = build(klass, content_type: 'image/jpg')
      expect(asset.image).to be_a(AssetImage)
    end
  end

  it '#actual_filename' do
    asset = create(klass)
    asset.write_attribute :filename, 'foo.pdf'
    expect(asset.actual_filename).to eq 'foo.pdf'
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:image?, :image, :actual_filename)
  end
end
