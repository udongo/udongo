require 'rails_helper'

describe Udongo::Configs::Pages do
  let(:klass) { described_class }
  let(:instance) { klass.new }

  describe 'defaults' do
    it :images do
      expect(klass.new.images).to eq false
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
    expect(klass.new).to respond_to(:images, :images=, :images?)
  end
end
