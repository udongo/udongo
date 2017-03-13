require 'rails_helper'

describe Backend::FormHelper do
  it '.trigger_dirty_inputs_warning' do
    expect(trigger_dirty_inputs_warning).to eq '<span data-dirty="true"></span>'
  end

  it '.responds_to?' do
    expect(self).to respond_to(
      :trigger_dirty_inputs_warning
    )
  end
end
