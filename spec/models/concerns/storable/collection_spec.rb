require 'rails_helper'

describe Concerns::Storable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:config) { Concerns::Storable::Config.new }

  it '#save' do
    page = create(:page)

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

  it '#delete' do
    page = create(:page)

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
    collection = model.new(create(:page), :default, config)
    expect(collection).to respond_to(:save)
  end
end
