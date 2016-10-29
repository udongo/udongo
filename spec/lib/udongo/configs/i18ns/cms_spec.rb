require 'rails_helper'

describe Udongo::Configs::I18ns::Cms do
  let(:klass) { described_class }

  describe 'defaults' do
    it :interface_locales do
      expect(klass.new.interface_locales).to eq %w(nl en)
    end

    it :default_interface_locale do
      expect(klass.new.default_interface_locale).to eq 'nl'
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :default_interface_locale, :default_interface_locale=, :interface_locales,
      :interface_locales
    )
  end
end
