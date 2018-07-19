require 'rails_helper'

describe Udongo::Search::Frontend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:controller) { double(:controller, class_name: 'Frontend', locale: 'nl') }
  subject { described_class.new('foo', controller: controller) }

  before(:each) do
    module Udongo::Search::ResultObjects::RSpec
      class Class < Udongo::Search::ResultObjects::Base
      end
    end
  end

  describe '#search' do
    let(:foo) { Udongo::BogusModel.new(description: 'foobar') }
    let(:index) { create(:search_index, searchable: foo, locale: 'nl', name: 'description', value: 'foobar') }

    before do
      allow(subject).to receive(:indices) { [index] }
    end

    it 'default' do
      expect(subject.search).to eq []
    end

    context 'filters on visibility' do
      it 'shows visible' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: false, unpublished?: false, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq [{ label: 'foobar', value: 'bar' }]
      end

      it 'skips hidden' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: true, unpublished?: false, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq []
      end
    end

    context 'filters on publishable state' do
      it 'shows published' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: false, unpublished?: false, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq [{ label: 'foobar', value: 'bar' }]
      end

      it 'skips unpublished' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: false, unpublished?: true, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq []
      end
    end

    context 'filters on presence URL method result' do
      it 'shows published' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: false, unpublished?: false, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq [{ label: 'foobar', value: 'bar' }]
      end

      it 'skips unpublished' do
        allow(subject).to receive(:result_object).with(index) do
          double(:result_object, hidden?: false, unpublished?: true, url: 'bar', label: 'foobar')
        end

        expect(subject.search).to eq []
      end
    end
  end

  it '#responds_to?' do
    expect(subject).to respond_to(
      :search, :indices, :result_object
    )
  end
end
