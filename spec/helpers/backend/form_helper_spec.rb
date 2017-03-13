require 'rails_helper'

describe Backend::FormHelper do
  it '.trigger_dirty_inputs_warning' do
    I18n.locale = :nl
    expect(trigger_dirty_inputs_warning).to eq "<span class=\"hidden-xs-up\" data-dirty=\"false\">Je gaat de pagina verlaten maar je aanpassingen zijn nog niet bewaard.\nWil je nog steeds de pagina verlaten?</span>"
  end

  it '.responds_to?' do
    expect(self).to respond_to(
      :trigger_dirty_inputs_warning
    )
  end
end
