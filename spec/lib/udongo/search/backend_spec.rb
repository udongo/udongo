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
