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
      expect(instance.filename).to eq 'rtlmt-x-foo.jpg'
    end

    it 'width' do
      expect(instance.filename(200)).to eq 'rtlmt-200x-foo.jpg'
    end

    it 'height' do
      expect(instance.filename(nil, 200)).to eq 'rtlmt-x200-foo.jpg'
    end

    it 'width x height' do
      expect(instance.filename(200, 200)).to eq 'rtlmt-200x200-foo.jpg'
    end

    describe 'action' do
      it 'resize_to_limit' do
        expect(instance.filename(200, 200, action: :resize_to_limit)).to eq 'rtlmt-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_limit')).to eq 'rtlmt-200x200-foo.jpg'
      end

      it 'resize_to_fit' do
        expect(instance.filename(200, 200, action: :resize_to_fit)).to eq 'rtft-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_fit')).to eq 'rtft-200x200-foo.jpg'
      end

      it 'resize_to_fill' do
        expect(instance.filename(200, 200, action: :resize_to_fill)).to eq 'rtfl-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_to_fill')).to eq 'rtfl-200x200-foo.jpg'
      end

      it 'resize_and_pad' do
        expect(instance.filename(200, 200, action: :resize_and_pad)).to eq 'rapd-200x200-foo.jpg'
        expect(instance.filename(200, 200, action: 'resize_and_pad')).to eq 'rapd-200x200-foo.jpg'
      end
    end

    it 'quality' do
      expect(instance.filename(200, 200, quality: 85)).to eq 'rtlmt-q85-200x200-foo.jpg'
      expect(instance.filename(200, 200, quality: '85')).to eq 'rtlmt-q85-200x200-foo.jpg'
    end

    it 'gravity' do
      expect(instance.filename(10, 10, gravity: 'NorthWest')).to eq 'rtlmt-gnw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'North')).to eq 'rtlmt-gn-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'NorthEast')).to eq 'rtlmt-gne-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'West')).to eq 'rtlmt-gw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'Center')).to eq 'rtlmt-gc-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'East')).to eq 'rtlmt-ge-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'SouthWest')).to eq 'rtlmt-gsw-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'South')).to eq 'rtlmt-gs-10x10-foo.jpg'
      expect(instance.filename(10, 10, gravity: 'SouthEast')).to eq 'rtlmt-gse-10x10-foo.jpg'
    end

    it 'background' do
      expect(instance.filename(200, 200, background: :yellow)).to eq 'rtlmt-byellow-200x200-foo.jpg'
      expect(instance.filename(200, 200, background: 'yellow')).to eq 'rtlmt-byellow-200x200-foo.jpg'
      expect(instance.filename(200, 200, background: '#336699')).to eq 'rtlmt-b336699-200x200-foo.jpg'
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

      expect(result).to eq 'rtfl-q15-gn-bgreen-200x250-foo.jpg'
    end
  end

  it '#respond_to?' do
    expect(klass.new(nil)).to respond_to(
      :filename, :url, :path, :resize_to_limit, :resize_to_fit, :resize_to_fill,
      :resize_and_pad, :main_dir, :second_dir
    )
  end
end
