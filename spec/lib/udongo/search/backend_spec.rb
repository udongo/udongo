require 'rails_helper'

describe Udongo::Search::Backend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo') }

  before(:each) do
    class Udongo::Search::ResultObjects::Foo < Udongo::Search::ResultObject
    end

    create(:search_module, name: 'Foo', weight: 1)
  end

  describe '#search' do
    it 'default' do
      expect(instance.search).to eq []
    end

    it 'raises error when resource class does not exist' do
      create(:search_module, name: 'Bar', weight: 1)
      instance = described_class.new('bar')
      index = create(:search_index, searchable_type: 'Bar', searchable_id: 5, value: 'bar')
      expect { instance.search }.to raise_error('You need to define Udongo::Search::ResultObjects::Bar#build in lib/udongo/search/result_objects/bar.rb')
    end

    it 'raises error when resource class exists, but does not have the #build method' do
      class Udongo::Search::ResultObjects::FooBar
      end

      create(:search_module, name: 'FooBar', weight: 1)
      instance = described_class.new('bar')
      index = create(:search_index, searchable_type: 'FooBar', searchable_id: 5, value: 'bar')
      expect { instance.search }.to raise_error('You need to define Udongo::Search::ResultObjects::FooBar#build in lib/udongo/search/result_objects/foo_bar.rb')
    end

    it 'single result' do
      # TODO:
    end

    it 'multiple results' do
      # TODO:
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :search, :indices, :result_object
    )
  end
end
