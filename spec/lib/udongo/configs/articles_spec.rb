require 'rails_helper'

describe Udongo::Configs::Articles do
  let(:klass) { described_class }
  let(:instance) { klass.new }

  describe 'defaults' do
    it :allow_html_in_title do
      expect(klass.new.allow_html_in_title).to eq false
    end

    it :allow_html_in_summary do
      expect(klass.new.allow_html_in_summary).to eq false
    end

    it :editor_for_summary do
      expect(klass.new.editor_for_summary).to eq false
    end

    it :images do
      expect(klass.new.images).to eq false
    end
  end

  describe '#allow_html_in_title?' do
    it :false do
      instance.allow_html_in_title = false
      expect(instance.allow_html_in_title?).to eq false
    end

    it :true do
      instance.allow_html_in_title = true
      expect(instance.allow_html_in_title?).to eq true
    end
  end

  describe '#allow_html_in_summary' do
    it :false do
      instance.allow_html_in_summary = false
      expect(instance.allow_html_in_summary?).to eq false
    end

    it :true do
      instance.allow_html_in_summary = true
      expect(instance.allow_html_in_summary?).to eq true
    end
  end

  describe '#editor_for_summary' do
    it :false do
      instance.editor_for_summary = false
      expect(instance.editor_for_summary?).to eq false
    end

    it :true do
      instance.editor_for_summary = true
      expect(instance.editor_for_summary?).to eq true
    end
  end

  describe '#images' do
    it :false do
      instance.images = false
      expect(instance.images?).to eq false
    end

    it :true do
      instance.images = true
      expect(instance.images?).to eq true
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :allow_html_in_title, :allow_html_in_title=, :allow_html_in_title?,
      :allow_html_in_summary, :allow_html_in_summary=, :allow_html_in_summary?,
      :editor_for_summary, :editor_for_summary=, :editor_for_summary?, :images,
      :images=, :images?
    )
  end
end
