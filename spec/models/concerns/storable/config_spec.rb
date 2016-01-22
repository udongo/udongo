require 'rails_helper'

describe Concerns::Storable::Config do
  let(:klass) { described_class }
  let(:config) { Concerns::Storable::Config.new }

  describe '#fields' do
    it :default do
      expect(config.fields).to eq({})
    end
  end

  describe '#add' do
    it 'as intended' do
      config.add(:first_name, :string)
      expect(config.fields).to eq({
        first_name: { klass: :string, default: nil }
      })
    end

    it 'as strings' do
      config.add('first_name', 'string', '')
      expect(config.fields).to eq({
        first_name: { klass: :string, default: ''}
      })
    end

    it 'only allow certain klasses' do
      klass::KLASSES.keys.each do |k|
        config.add(:foo, k)
        expect(config.fields[:foo][:klass]).to eq k.to_sym
      end

      %w(foo bar baz).each do |k |
        expect { config.add(:foo, k) }.to raise_error("#{k} is not a valid storable config klass")
      end
    end
  end

  describe '#allowed?' do
    it :true do
      config.add(:foo, :string)
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
