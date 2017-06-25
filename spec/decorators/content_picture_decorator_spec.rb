require 'rails_helper'

describe ContentPictureDecorator do
  describe '#max_image_size' do
    let(:picture) { create(:content_picture).decorate }

    it 'content width xl: 1' do
      create(:content_column, content: picture, width_xl: 1)
      expect(picture.max_image_size).to eq 133
    end

    it 'content width xl: 2' do
      create(:content_column, content: picture, width_xl: 2)
      expect(picture.max_image_size).to eq 266
    end

    it 'content width xl: 3' do
      create(:content_column, content: picture, width_xl: 3)
      expect(picture.max_image_size).to eq 400
    end

    it 'content width xl: 4' do
      create(:content_column, content: picture, width_xl: 4)
      expect(picture.max_image_size).to eq 533
    end

    it 'content width xl: 5' do
      create(:content_column, content: picture, width_xl: 5)
      expect(picture.max_image_size).to eq 666
    end

    it 'content width xl: 6' do
      create(:content_column, content: picture, width_xl: 6)
      expect(picture.max_image_size).to eq 800
    end

    it 'content width xl: 7' do
      create(:content_column, content: picture, width_xl: 7)
      expect(picture.max_image_size).to eq 933
    end

    it 'content width xl: 8' do
      create(:content_column, content: picture, width_xl: 8)
      expect(picture.max_image_size).to eq 1066
    end

    it 'content width xl: 9' do
      create(:content_column, content: picture, width_xl: 9)
      expect(picture.max_image_size).to eq 1200
    end

    it 'content width xl: 10' do
      create(:content_column, content: picture, width_xl: 10)
      expect(picture.max_image_size).to eq 1333
    end

    it 'content width xl: 11' do
      create(:content_column, content: picture, width_xl: 11)
      expect(picture.max_image_size).to eq 1466
    end

    it 'content width xl: 12' do
      create(:content_column, content: picture, width_xl: 12)
      expect(picture.max_image_size).to eq 1600
    end
  end

  it '#respond_to?' do
    expect(build(:content_picture).decorate).to respond_to(:max_image_size)
  end
end
