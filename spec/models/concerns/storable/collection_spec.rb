require 'rails_helper'

describe Concerns::Storable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:config) { Concerns::Storable::Config.new }
  let(:page) { create(:page) }

  # TODO: Split up tests; 1 expect / test.
  it '#save' do
    config.add :locales, Array
    config.add :active, Axiom::Types::Boolean
    config.add :starts_on, Date
    config.add :starts_at, DateTime
    config.add :discount, Float
    config.add :age, Integer
    config.add :email, String

    collection = model.new(page, :custom, config)
    collection.locales = [:nl, :fr]
    collection.active = true
    collection.starts_on = Date.today
    collection.starts_at = DateTime.parse('2016-01-07 14:45')
    collection.discount = 13.37
    collection.age = 37
    collection.email = 'foo@bar.baz'
    collection.save

    collection = model.new(page, :custom, config)
    expect(collection.locales).to eq [:nl, :fr]
    expect(collection.active).to eq true
    expect(collection.starts_on).to eq Date.today
    expect(collection.starts_at).to eq DateTime.parse('2016-01-07 14:45')
    expect(collection.discount).to eq 13.37
    expect(collection.age).to eq 37
    expect(collection.email).to eq 'foo@bar.baz'
  end

  it '#define_reader_method_for_uploader_field' do
    store = create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
    config.add :foo, String
    instance = described_class.new(page, :custom, config)
    instance.define_reader_method_for_uploader_field(:foo, { type: String })
    expect(instance).to respond_to(:foo)
  end

  it '#define_writer_method_for_uploader_field' do
    store = create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
    config.add :foo, String
    instance = described_class.new(page, :custom, config)
    instance.define_writer_method_for_uploader_field(:foo, { type: String })
    expect(instance).to respond_to('foo=')
  end

  describe '#store' do
    let(:instance) { described_class.new(page, :custom, config) }
    before(:each) { config.add :foo, String }

    it 'no result' do
      expect(instance.store(:foo).id).to eq nil
    end

    it 'with result' do
      store = create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
      expect(instance.store(:foo).id).to eq store.id
    end

    it 'file: true' do
      store = create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
      expect(instance.store(:foo, file: true).id).to eq store.id
    end
  end

  describe '#stores' do
    let(:instance) { described_class.new(page, :custom, config) }
    before(:each) { config.add :foo, String }

    it 'no result' do
      expect(instance.stores).to eq []
    end

    it 'with result' do
      create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
      stores = instance.stores
      expect(stores.first.class).to eq Store
    end

    it 'file: true' do
      create(:store, storable: page, name: 'foo', value: 'bar', collection: :custom)
      stores = instance.stores(file: true)
      expect(stores.first.class).to eq StoreWithFile
    end
  end

  it '#delete' do
    config.add :foo, String
    config.add :bar, String

    collection = model.new(page, :custom, config)
    collection.foo = 'foo'
    collection.bar = 'bar'
    collection.save

    collection = model.new(page, :custom, config)
    expect(collection.delete).to eq true

    expect(collection.foo).to eq nil
    expect(collection.bar).to eq nil
  end

  it '#respond_to?' do
    collection = described_class.new(page, :default, config)
    expect(collection).to respond_to(
      :delete, :store, :stores, :save
    )
  end
end
