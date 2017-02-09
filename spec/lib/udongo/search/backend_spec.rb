require 'rails_helper'

describe Udongo::Search::Backend do
  let(:klass) { described_class.to_s.underscore.to_sym }
  let(:instance) { described_class.new('foo', namespace: 'Backend') }

  before(:each) do
    class Udongo::Search::ResultObjects::Backend::Foo < Udongo::Search::ResultObject
      def url
        '/backend/pages/1/edit'
      end
    end

    create(:search_module, name: 'Foo', weight: 1)
  end

  describe '#search' do
    it 'default' do
      expect(instance.search).to eq []
    end

    context 'results' do
      let(:controller) { Backend::BaseController.new }
      let(:instance) { described_class.new('foobar', controller: controller) }

      before(:each) do
        allow(controller).to receive(:edit_backend_page_path) { 'backend/pages/1/edit' }
        @page_a = create(:page, description: 'foobar')
        @page_b = create(:page, description: 'foobar too')
        @index_a = create(:search_index, searchable: @page_a, locale: 'nl', name: 'description', value: 'foobar')
        allow(File).to receive(:exists?) { true }
      end

      it 'single' do
        allow(instance).to receive(:indices) { [@index_a] }

        expect(instance.search).to eq [{ label: "Pagina — <br />\n<small>\n  foobar\n</small>\n", value: 'backend/pages/1/edit' }]
      end

      it 'multiple' do
        index_b = create(:search_index, searchable: @page_b, locale: 'nl', name: 'description', value: 'foobar too')
        allow(instance).to receive(:indices) { [@index_a, index_b] }

        expect(instance.search).to eq [
          { label: "Pagina — <br />\n<small>\n  foobar\n</small>\n", value: 'backend/pages/1/edit' },
          { label: "Pagina — <br />\n<small>\n  foobar too\n</small>\n", value: 'backend/pages/1/edit' }
        ]
      end
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :search, :indices, :result_object
    )
  end
end
