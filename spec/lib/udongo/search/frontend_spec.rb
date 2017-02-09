require 'rails_helper'

describe Udongo::Search::Frontend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo') }

  before(:each) do
    class Udongo::Search::ResultObjects::Foo < Udongo::Search::ResultObject
    end

    create(:search_module, name: 'Page', weight: 1)
  end

  describe '#search' do
    it 'default' do
      expect(instance.search).to eq []
    end

    it 'filters on visibility' do
      create(:page, description: 'foobar', visible: false)
      page = create(:page, description: 'foobar', visible: true)
      index = create(:search_index, searchable: page, locale: 'nl', name: 'description', value: 'foobar')
      allow(instance).to receive(:indices) { [index] }

      expect(instance.search).to eq [{ label: 'foobar', value: nil }]
    end

    it 'filters on publishable state' do
      create(:page, description: 'foobar', visible: true)
      page = create(:page, description: 'foobar', visible: true)
      allow(page).to receive(:unpublished?) { true }
      index = create(:search_index, searchable: page, locale: 'nl', name: 'description', value: 'foobar')
      allow(instance).to receive(:indices) { [index] }

      expect(instance.search).to eq [{ label: 'foobar', value: nil }]
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :search, :indices, :result_object
    )
  end
end
