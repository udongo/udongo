require 'rails_helper'

describe Concerns::Storable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  before(:each) do
    @config = Concerns::Storable::Config.new
  end

  describe '#read / #write' do
    it 'read from unknown field' do
      collection = model.new(::Page.new, @config)
      expect { collection.foo }.to raise_error(NoMethodError)
    end

    it 'write to unknown field' do
      collection = model.new(::Page.new, @config)
      expect { collection.foo = 'bar' }.to raise_error(NoMethodError)
    end

    it 'defaults to nil' do
      @config.add :foo, :string
      collection = model.new(::Page.new, @config)

      expect(collection.foo).to eq nil
    end

    it 'defaults to provided default' do
      @config.add :foo, :string, 'bar'
      collection = model.new(::Page.new, @config)

      expect(collection.foo).to eq 'bar'
    end

    describe 'array' do
    end

    describe 'boolean' do
    end

    describe 'date' do
    end

    describe 'date_time' do
    end

    describe 'float' do
    end

    describe 'integer' do
    end

    describe 'string' do
    end
  end

  # before(:each) do
  #   config = Concerns::Translatable::Config.new
  #   config.add(:title)
  #   config.add(:subtitle)
  #
  #   @collection = model.new(
  #     ::Page.new, config, :nl
  #   )
  # end
  #
  # describe '#read' do
  #   it 'cannot read when not in config' do
  #     expect { @collection.foo_bar_baz }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'reads if translation is new' do
  #     expect(@collection.title).not_to be_present
  #   end
  #
  #   it 'reads if translation exists' do
  #     @collection.title = 'foo'
  #     expect(@collection.title).to eq 'foo'
  #   end
  # end
  #
  # describe '#write' do
  #   it 'cannot write fields in the config' do
  #     expect { @collection.foo_bar == 'baz' }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'writes if translation is new' do
  #     @collection.title = 'foo'
  #     expect(@collection.title).to eq 'foo'
  #   end
  #
  #   it 'writes if translation exists' do
  #     Translation.create!(
  #       translatable_type: 'Page',
  #       translatable_id: 1,
  #       locale: 'nl',
  #       name: 'title',
  #       value: 'foo'
  #     )
  #
  #     @collection.title = 'bar'
  #     expect(@collection.title).to eq 'bar'
  #   end
  # end
  #
  # it '#save' do
  #   @collection.title = 'foo'
  #   @collection.subtitle = 'bar'
  #   @collection.save
  #
  #   config = Concerns::Translatable::Config.new
  #   config.add(:title)
  #   config.add(:subtitle)
  #
  #   new_collection = Concerns::Translatable::Collection.new(::Page.new, config, :nl)
  #   expect(new_collection.title).to eq 'foo'
  #   expect(new_collection.subtitle).to eq 'bar'
  # end

  it '#respond_to?' do
    collection = model.new(::Page.new, @config)
    expect(collection).to respond_to(:save, :read, :write)
  end
end
