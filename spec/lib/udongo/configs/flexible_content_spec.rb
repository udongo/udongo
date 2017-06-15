require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:klass) { described_class }
  let(:instance) { described_class.new }

  describe 'defaults' do
    it :BREAKPOINTS do
      expect(klass::BREAKPOINTS).to eq %w(xs sm md lg xl)
    end

    it :types do
      expect(instance.types).to eq %w(text picture video slideshow form image)
    end

    it :picture_caption_editor do
      expect(instance.picture_caption_editor).to eq false
    end
  end

  describe '#picture_caption_editor?' do
    it :true do
      instance.picture_caption_editor = true
      expect(instance.picture_caption_editor?).to eq true
    end

    it :false do
      instance.picture_caption_editor = false
      expect(instance.picture_caption_editor?).to eq false
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :types, :types=, :picture_caption_editor, :picture_caption_editor=,
      :picture_caption_editor?
    )
  end
end
