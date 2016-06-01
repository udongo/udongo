require 'rails_helper'

describe Concerns::Storable::Config do
  let(:klass) { described_class }
  let(:config) { Concerns::Storable::Config.new }

  it '#fields' do
    expect(config.fields).to eq({})
  end

  describe '#add' do
    it 'without default value' do
      config.add :first_name, String
      expect(config.fields).to eq ({
        first_name: { type: String, default: nil }
      })
    end

    it 'with default value' do
      config.add :first_name, String, 'foo'
      expect(config.fields).to eq ({
        first_name: { type: String, default: 'foo' }
      })
    end
  end

  describe '#allowed?' do
    it :true do
      config.add :foo, String
      expect(config).to be_allowed('foo')
    end

    it :false do
      expect(config).not_to be_allowed('foo')
    end
  end

  it '#respond_to?' do
    expect(config).to respond_to(:add, :fields, :allowed?)
  end
end
