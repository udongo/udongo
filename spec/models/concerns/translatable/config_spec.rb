require 'rails_helper'

describe Concerns::Translatable::Config do
  let(:config) { Concerns::Translatable::Config.new }

  it('default config is blank') { expect(config.fields).to eq [] }

  describe '#fields' do
    before(:each) { config.add(:foo) }

    it(:adds) { expect(config.fields).to eq [:foo] }

    it 'adding twice overwrites the type' do
      config.add(:foo, type: :text)
      expect(config.type(:foo)).to eq :text
    end
  end

  describe '#type' do
    before(:each) do
      config.add(:foo, type: :string)
      config.add(:bar, type: :text)
    end

    it :string do
      expect(config.type(:foo)).to eq :string
    end

    it :text do
      expect(config.type(:bar)).to eq :text
    end

    it :exception do
      expect { config.type(:baz) }.to raise_exception
    end
  end

  describe '#allowed?' do
    it :true do
      config.add(:foo)
      expect(config).to be_allowed(:foo)
    end

    it(:false) { expect(config).not_to be_allowed(:foo) }
  end

  it '#respond_to?' do
    expect(config).to respond_to(:add, :fields, :allowed?, :type)
  end
end
