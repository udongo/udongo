require 'rails_helper'

describe Udongo::Search::ResultObject do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:index) { create(:search_index, searchable_type: 'Foo', searchable_id: 1, value: 'foo') }
  let(:instance) { described_class.new(index) }

  it '#build_html' do
    # TODO: Not sure how to test ApplicationController.render calls.
  end

  it '#locals' do
    allow(index).to receive(:searchable) { 'bar' }
    expect(instance.locals).to eq({ foo: 'bar', index: index })
  end

  describe '#namespace' do
    it 'default' do
      instance = described_class.new(index)
      expect(instance.namespace).to eq :frontend
    end

    it 'backend' do
      instance = described_class.new(index, controller: Backend::SearchController.new)
      expect(instance.namespace).to eq :backend
    end
  end

  it '#partial' do
    expect(instance.partial(:backend)).to eq 'backend/search/result_rows/foo'
  end

  it '#partial_target' do
    index = create(:search_index, searchable_type: 'FooBar')
    instance = described_class.new(index)
    expect(instance.partial_target).to eq 'foo_bar'
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :build_html, :locals, :partial, :partial_target, :namespace
    )
  end
end
