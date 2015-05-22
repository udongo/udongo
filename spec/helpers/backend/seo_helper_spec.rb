require 'rails_helper'

describe Backend::SeoHelper do
  describe '#seo_base_path' do
    let(:request) { Struct.new(:protocol, :host) }
    let(:form) { Struct.new(:object_name) }
    before(:each) do
      allow(form).to receive(:object_name) { 'article' }
      allow(request).to receive(:protocol) { 'http://' }
      allow(request).to receive(:host) { 'udongo.dev' }
    end

    it :fallback do
      expect(seo_base_path(request, form, 'nl')).to eq 'http://udongo.dev/nl'
    end

    it :specific do
      allow(form).to receive(:object_name) { 'article' }
      allow(self).to receive("#{form.object_name.pluralize}_nl_path") do
        'http://udongo.dev/nl/articles'
      end

      expect(seo_base_path(request, form, 'nl')).to eq 'http://udongo.dev/nl/articles'
    end
  end
end
