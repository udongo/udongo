require 'rails_helper'

describe Udongo::Search::Base do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo') }

  before(:each) do
    module Udongo::Search::ResultObjects
      module Frontend
        class Foo < Udongo::Search::ResultObject
        end
      end
    end
  end

  # TODO: Move to an initializer so it's accessible wherever?
  describe '#class_exists?' do
    it 'true' do
      expect(instance.class_exists?('Udongo::Search::ResultObjects::Frontend::Foo')).to be true
    end

    it 'false' do
      expect(instance.class_exists?('Udongo::Search::ResultObjects::Frontend::Bar')).to be false
    end
  end

  describe '#indices' do
    it 'default' do
      expect(instance.indices).to eq []
    end

    it 'term is an empty string' do
      expect(described_class.new('').indices).to eq []
    end

    it 'returns results sorted by SearchModule weight' do
      create(:search_module, name: 'Foo', weight: 1)
      create(:search_module, name: 'Bar', weight: 10)
      create(:search_module, name: 'Baz', weight: 5)

      a = create(:search_index, searchable_type: 'Bar', searchable_id: 1, value: 'foo')
      b = create(:search_index, searchable_type: 'Bar', searchable_id: 2, value: 'foo')
      c = create(:search_index, searchable_type: 'Foo', searchable_id: 5, value: 'foo')
      d = create(:search_index, searchable_type: 'Foo', searchable_id: 8, value: 'foo')
      e = create(:search_index, searchable_type: 'Baz', searchable_id: 18, value: 'foo')

      expect(instance.indices).to eq [a, b, e, c, d]
    end

    it 'returns results triggered by a SearchSynonym' do
      create(:search_module, name: 'Foo', weight: 1)

      create(:search_synonym, term: 'foo', synonyms: 'bar,baz')

      a = create(:search_index, searchable_type: 'Foo', searchable_id: 1, value: 'foo')
      b = create(:search_index, searchable_type: 'Foo', searchable_id: 2, value: 'blub')
      c = create(:search_index, searchable_type: 'Foo', searchable_id: 5, value: 'bar')
      d = create(:search_index, searchable_type: 'Foo', searchable_id: 8, value: 'foo too')
      e = create(:search_index, searchable_type: 'Foo', searchable_id: 18, value: 'baz')

      instance = described_class.new('bar')
      expect(instance.indices).to eq [a, d]
    end
  end

  describe '#result_object' do
    let(:index) do
      create(:search_index, searchable_type: 'Foo', searchable_id: 5, value: 'foo')
    end

    it 'index maps to Udongo::Search::ResultObject when a specific resource object was not found' do
      allow(instance).to receive(:result_object_exists?) { false }
      expect(instance.result_object(index)).to be_instance_of(Udongo::Search::ResultObject)
    end

    it 'index maps to a specific ResultObjects resource class' do
      allow(instance).to receive(:result_object_exists?) { true }
      expect(instance.result_object(index)).to be_instance_of(Udongo::Search::ResultObjects::Frontend::Foo)
    end
  end

  describe '#result_object_exists?' do
    it 'true' do
      # This gives true without more info because the class extends from
      # Udongo::Search::ResultObject
      allow(instance).to receive(:result_object_exists?) { true }
      expect(instance.result_object_exists?('Udongo::Search::ResultObjects::Foo')).to be true
    end

    describe 'false' do
      it 'class does not exist' do
        allow(instance).to receive(:class_exists?) { false }
        expect(instance.result_object_exists?('')).to be false
      end

      it 'class exists, no #build_html method defined' do
        class Udongo::Search::ResultObjects::Blub
        end
        expect(instance.result_object_exists?('Udongo::Search::ResultObjects::Blub')).to be false
      end
    end
  end

  describe '#namespace' do
    it 'default' do
      instance = described_class.new('foo')
      expect(instance.namespace).to eq 'Frontend'
    end

    it 'backend' do
      instance = described_class.new('foo', controller: Backend::SearchController.new)
      expect(instance.namespace).to eq 'Backend'
    end

    it 'uses override when passed in through the construct' do
      instance = described_class.new('foo', controller: Backend::SearchController.new, namespace: 'Frontend')
      expect(instance.namespace).to eq 'Frontend'
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :indices
    )
  end
end
