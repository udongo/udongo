require 'rails_helper'

describe Udongo::Search::Backend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo') }

  before(:each) do
    class Udongo::Search::ResultObjects::Foo < Udongo::Search::ResultObject
    end

    create(:search_module, name: 'Foo', weight: 1)
  end

  describe '#find' do
    it 'default' do
      expect(instance.find).to eq []
    end

    it 'single result' do
      # TODO:
    end

    it 'multiple results' do
      # TODO:
    end
  end

  describe '#result_object' do
    let(:index) do
      create(:search_index, searchable_type: 'Foo', searchable_id: 5, value: 'foo')
    end

    it 'index maps to a ResultObjects class' do
      expect(instance.result_object(index)).to be_instance_of(Udongo::Search::ResultObjects::Foo)
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :find, :result_object
    )
  end
end