require 'rails_helper'

describe Concerns::Addressable::Config do
  let(:klass) { described_class }
  let(:config) { Concerns::Addressable::Config.new }

  it '#fields' do
    expect(config.fields).to eq([])
  end

  describe '#update' do
    describe 'categories' do
      it 'categories = nil' do
        expect { config.update(nil) }.to raise_error(RuntimeError, 'Please provide an array with address categories')
      end

      it 'categories = []' do
        expect { config.update(nil) }.to raise_error(RuntimeError, 'Please provide an array with address categories')
      end

      it 'categories = list of symbols' do
        config.update [:foo, :bar, :baz]
        expect(config.fields).to eq [:foo, :bar, :baz]
        expect(config.default).to eq :foo
      end

      it 'categories = list of strings' do
        config.update %w(foo bar baz)
        expect(config.fields).to eq [:foo, :bar, :baz]
        expect(config.default).to eq :foo
      end

      it 'categories contain duplicates' do
        config.update [:foo, 'foo', :bar, 'bar', 'baz', :baz, :baz]
        expect(config.fields).to eq [:foo, :bar, :baz]
        expect(config.default).to eq :foo
      end
    end

    describe 'default' do
      it 'default = nil' do
        config.update [:foo]
        expect(config.default).to eq :foo
      end

      it 'default = baz (not in the list of categories)' do
        expect { config.update([:foo, :bar], default: :baz) }.to raise_error(RuntimeError, "You can't make 'baz' the default address category because it's not in the list of categories")
      end

      describe 'default = in the list of categories' do
        it 'first category' do
          config.update [:foo, :bar, :baz], default: :foo
          expect(config.default).to eq :foo
        end

        it 'second category' do
          config.update [:foo, :bar, :baz], default: :bar
          expect(config.default).to eq :bar
        end

        it 'third category' do
          config.update [:foo, :bar, :baz], default: :baz
          expect(config.default).to eq :baz
        end
      end
    end
  end

  describe '#allowed?' do
    it :true do
      config.update [:foo]
      expect(config).to be_allowed('foo')
    end

    it :false do
      config.update [:foo]
      expect(config).not_to be_allowed('bar')
    end
  end

  it '#respond_to?' do
    expect(config).to respond_to(:fields, :default, :update, :allowed?)
  end
end
