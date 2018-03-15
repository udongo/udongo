require 'rails_helper'

describe Udongo::Search::Frontend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  subject { described_class.new('foo') }

  before(:each) do
    module Udongo::Search::ResultObjects::Frontend
      class Class < Udongo::Search::ResultObjects::Base
      end
    end
  end

  describe '#search' do
    it 'default' do
      expect(subject.search).to eq []
    end

    context 'filters on visibility' do
      it 'shows visible' do
        foo = Udongo::BogusModel.new(
          description: 'foobar',
          visible?: true,
          hidden?: false,
          published?: true,
          unpublished?: false
        )

        index = create(:search_index, searchable: foo, locale: 'nl', name: 'description', value: 'foobar')
        allow(subject).to receive(:indices) { [index] }

        expect(subject.search).to eq [{ label: 'foobar', value: nil }]
      end

      it 'skips hidden' do
        foo = Udongo::BogusModel.new(
          description: 'foobar',
          visible?: false,
          hidden?: true,
          published?: true,
          unpublished?: false
        )

        index = create(:search_index, searchable: foo, locale: 'nl', name: 'description', value: 'foobar')
        allow(subject).to receive(:indices) { [index] }

        expect(subject.search).to eq []
      end
    end

    context 'filters on publishable state' do
      it 'shows published' do
        foo = Udongo::BogusModel.new(
          description: 'foobar',
          visible?: true,
          hidden?: false,
          published?: true,
          unpublished?: false
        )

        index = create(:search_index, searchable: foo, locale: 'nl', name: 'description', value: 'foobar')
        allow(subject).to receive(:indices) { [index] }

        expect(subject.search).to eq [{ label: 'foobar', value: nil }]
      end

      it 'skips unpublished' do
        foo = Udongo::BogusModel.new(
          description: 'foobar',
          visible?: true,
          hidden?: false,
          published?: false,
          unpublished?: true
        )

        index = create(:search_index, searchable: foo, locale: 'nl', name: 'description', value: 'foobar')
        allow(subject).to receive(:indices) { [index] }

        expect(subject.search).to eq []
      end

      it 'skips indices that have no valid URL' do
        # TODO: Currently only tested by live example, so review this later.
        # I don't seem to end up within the scope of the #search method as I
        # would assume.
      end
    end
  end

  it '#responds_to?' do
    expect(subject).to respond_to(
      :search, :indices, :result_object
    )
  end
end
