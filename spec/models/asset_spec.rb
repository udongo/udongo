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

  describe 'scopes' do
    it '.image' do
      a = create(klass)
      a.update_column :content_type, 'image/jpeg'

      b = create(klass)
      b.update_column :content_type, 'application/pdf'

      c = create(klass)
      c.update_column :content_type, 'image/gif'

      d = create(klass)
      d.update_column :content_type, 'image/png'

      expect(described_class.image.order(:id)).to eq [a, c, d]
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

    it 'Udongo::Assets::Resizer' do
      asset = build(klass, content_type: 'image/jpg')
      expect(asset.image).to be_a(Udongo::Assets::Resizer)
    end
  end

  it '#actual_filename' do
    asset = create(klass)
    asset.write_attribute :filename, 'foo.pdf'
    expect(asset.actual_filename).to eq 'foo.pdf'
  end

  describe '#deletable?' do
    it :true do
      expect(create(klass)).to be_deletable
    end

    it 'has an image' do
      asset = create(klass)
      create(:image, asset: asset, imageable: create(:page))
      expect(asset).not_to be_deletable
    end

    it 'has a content picture' do
      asset = create(klass)
      create(:content_picture, asset: asset)
      expect(asset).not_to be_deletable
    end

    it 'has an attachment' do
      asset = create(klass)
      create(:attachment, asset: asset)
      expect(asset).not_to be_deletable
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(
      :image?, :image, :images, :actual_filename, :deletable?,
      :content_pictures, :attachments
    )
  end
end
