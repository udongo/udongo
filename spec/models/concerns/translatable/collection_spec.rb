require 'rails_helper'

class TestCollection
  def id
    1
  end
end

describe Concerns::Translatable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  before(:each) do
    config = Concerns::Translatable::Config.new
    config.add(:title)
    config.add(:description)

    @collection = model.new(
      TestCollection.new, config, :nl
    )
  end

  describe '#read' do
    it 'cannot read when not in config' do
      expect { @collection.foo_bar_baz }.to raise_error(NoMethodError)
    end

    it 'reads if translation is new' do
      expect(@collection.title).not_to be_present
    end

    it 'reads if translation exists' do
      Translation.create!(
        translatable_type: 'TestCollection',
        translatable_id: 1,
        locale: :nl,
        name: 'title',
        value: 'foo'
      )

      expect(@collection.title).to eq 'foo'
    end
  end

  describe '#write' do
    it 'cannot write fields in the config' do
      expect { @collection.foo_bar == 'baz' }.to raise_error(NoMethodError)
    end

    it 'writes if translation is new' do
      @collection.title = 'foo'
      expect(@collection.title).to eq 'foo'
    end

    it 'writes if translation exists' do
      Translation.create!(
        translatable_type: 'TestCollection',
        translatable_id: 1,
        locale: 'nl',
        name: 'title',
        value: 'foo'
      )

      @collection.title = 'bar'
      expect(@collection.title).to eq 'bar'
    end
  end

  it '#save' do
    @collection.title = 'foo'
    @collection.description = 'bar'
    @collection.save

    config = Concerns::Translatable::Config.new
    config.add(:title)
    config.add(:description)

    new_collection = Concerns::Translatable::Collection.new(TestCollection.new, config, :nl)
    expect(new_collection.title).to eq 'foo'
    expect(new_collection.description).to eq 'bar'
  end

  it '#respond_to?' do
    expect(@collection).to respond_to(:save, :read, :write)
  end
end
