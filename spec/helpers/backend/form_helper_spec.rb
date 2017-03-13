require 'rails_helper'

describe Backend::FormHelper do
  describe '.trigger_dirty_inputs_warning' do
    before(:each) do
      I18n.locale = :nl
    end

    it 'default' do
      expect(trigger_dirty_inputs_warning).to eq "<span class=\"hidden-xs-up\" data-dirty=\"false\">Je gaat de pagina verlaten maar je aanpassingen zijn nog niet bewaard.\nWil je nog steeds de pagina verlaten?</span>"
    end

    it 'with custom message' do
      expect(trigger_dirty_inputs_warning(message: 'foo')).to eq "<span class=\"hidden-xs-up\" data-dirty=\"false\">foo</span>"
    end
  end

  it '.responds_to?' do
    expect(self).to respond_to(
      :trigger_dirty_inputs_warning
    )
  end
end
