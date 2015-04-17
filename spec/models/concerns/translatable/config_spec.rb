require 'rails_helper'

describe Concerns::Translatable::Config do
  let(:config) { Concerns::Translatable::Config.new }

  describe '#fields' do
    it :default do
      expect(config.fields).to eq []
    end
  end

  describe '#add' do
    it 'adds field' do
      config.add(:foo)
      expect(config.fields).to eq [:foo]
    end

    it 'adds only once' do
      2.times { config.add(:foo) }
      expect(config.fields).to eq [:foo]
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
    expect(config).to respond_to(:add, :fields, :allowed?)
  end
end
