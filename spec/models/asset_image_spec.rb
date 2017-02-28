require 'rails_helper'

describe AssetImage do
  let(:klass) { described_class }
  let :instance do
    asset = create(:asset)
    asset.update_column :filename, 'foo.jpg'
    asset.update_column :content_type, 'image/jpeg'

    klass.new(asset)
  end

  describe '#filename' do
    it 'no arguments' do
      expect(instance.filename).to eq 'limit-x-foo.jpg'
    end

    it 'width' do
      expect(instance.filename(200)).to eq 'limit-200x-foo.jpg'
    end

    it 'height' do
      expect(instance.filename(nil, 200)).to eq 'limit-x200-foo.jpg'
    end

    it 'width x height' do
      expect(instance.filename(200, 200)).to eq 'limit-200x200-foo.jpg'
    end

    describe 'action' do
      it 'resize_to_limit' do
        expect(instance.filename(200, 200, action: :resize_to_limit)).to eq 'limit-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_limit')).to eq 'limit-200x200-foo.jpg'
      end

      it 'resize_to_fit' do
        expect(instance.filename(200, 200, action: :resize_to_fit)).to eq 'fit-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_fit')).to eq 'fit-200x200-foo.jpg'
      end

      it 'resize_to_fill' do
        expect(instance.filename(200, 200, action: :resize_to_fill)).to eq 'fill-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_fill')).to eq 'fill-200x200-foo.jpg'
      end

      it 'resize_and_pad' do
        expect(instance.filename(200, 200, action: :resize_and_pad)).to eq 'pad-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_and_pad')).to eq 'pad-200x200-foo.jpg'
      end
    end

    it 'quality' do
      expect(instance.filename(200, 200, quality: 85)).to eq 'limit-q85-200x200-foo.jpg'
      expect(instance.filename(200, 200, quality: '85')).to eq 'limit-q85-200x200-foo.jpg'
    end

    it 'gravity' do
      expect(instance.filename(10, 10, gravity: 'NorthWest')).to eq 'limit-gnw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'North')).to eq 'limit-gn-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'NorthEast')).to eq 'limit-gne-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'West')).to eq 'limit-gw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'Center')).to eq 'limit-gc-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'East')).to eq 'limit-ge-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'SouthWest')).to eq 'limit-gsw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'South')).to eq 'limit-gs-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'SouthEast')).to eq 'limit-gse-10x10-foo.jpg'
    end

    it 'background' do
      expect(instance.filename(200, 200, background: :yellow)).to eq 'limit-byellow-200x200-foo.jpg'
      expect(instance.filename(200, 200, background: 'yellow')).to eq 'limit-byellow-200x200-foo.jpg'
      expect(instance.filename(200, 200, background: '#336699')).to eq 'limit-b336699-200x200-foo.jpg'
    end

    it 'all combined' do
      result = instance.filename(
        200,
        250,
        action: :resize_to_fill,
        quality: 15,
        gravity: 'North',
        background: 'green'
      )

      expect(result).to eq 'fill-q15-gn-bgreen-200x250-foo.jpg'
    end
  end

  it '#respond_to?' do
    expect(klass.new(nil)).to respond_to(
      :filename, :url, :path, :resize_to_limit, :resize_to_fit, :resize_to_fill,
      :resize_and_pad, :main_dir, :second_dir
    )
  end
end
