require 'rails_helper'

describe Udongo::Search::ResultObjects::Base do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:index) { create(:search_index, searchable_type: 'Foo', searchable_id: 1, value: 'foo') }
  let(:search_context) { Udongo::Search::Base.new('foo') }
  let(:instance) { described_class.new(index, search_context: search_context) }

  describe '#label' do
    let(:page) { create(:page) }

    before(:each) do
      allow(page).to receive(:foo) { 'foobar' }
    end

    it 'default' do
      index = create(:search_index, searchable: page, name: 'foo', value: 'foobar')
      instance = described_class.new(index, search_context: search_context)

      expect(instance.label).to eq 'foobar'
    end

    it 'flexible_content' do
      text = create(:content_text, content: 'This search is foobar.')
      index = create(:search_index, searchable: page, name: "flexible_content:#{text.id}", value: 'foobar')
      instance = described_class.new(index, search_context: search_context)

      expect(instance.label).to eq 'This search is foobar.'
    end
  end

  it '#locals' do
    allow(index).to receive(:searchable) { 'bar' }
    expect(instance.locals).to eq({ foo: 'bar', index: index })
  end

  it '#partial' do
    expect(instance.partial).to eq 'frontend/search/foo'
  end

  it '#partial_path' do
    expect(instance.partial_path).to eq 'frontend/search'
  end

  it '#partial_target' do
    index = create(:search_index, searchable_type: 'FooBar')
    instance = described_class.new(index)
    expect(instance.partial_target).to eq 'foo_bar'
  end

  describe '#hidden?' do
    let(:page) { create(:page) }
    let(:index) { create(:search_index, searchable: page, name: 'foo', value: 'bar') }
    let(:instance) { described_class.new(index, search_context: search_context) }

    it 'false' do
      allow(instance.searchable).to receive(:visible?) { true }
      expect(instance.hidden?).to be false
    end

    it 'true' do
      allow(instance.searchable).to receive(:visible?) { false }
      expect(instance.hidden?).to be true
    end
  end

  describe '#unpublished?' do
    let(:page) { create(:page) }
    let(:index) { create(:search_index, searchable: page, name: 'foo', value: 'bar') }
    let(:instance) { described_class.new(index, search_context: search_context) }

    it 'true' do
      allow(instance.searchable).to receive(:unpublished?) { true }
      expect(instance.unpublished?).to be false
    end

    it 'false' do
      allow(instance.searchable).to receive(:unpublished?) { true }
      expect(instance.unpublished?).to be false
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :build_html, :locals, :partial, :partial_target, :hidden?, :unpublished?,
      :partial_path, :url
    )
  end
end
