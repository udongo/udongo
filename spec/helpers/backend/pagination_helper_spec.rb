require 'rails_helper'

describe Backend::PaginationHelper do
  describe '#udongo_paginate' do
    it 'calls will_paginate' do
      allow(self).to receive(:will_paginate) { 'foobar' }
      expect(udongo_paginate([])).to eq 'foobar'
    end
  end

  it '#responds_to?' do
    expect(self).to respond_to(:udongo_paginate)
  end
end
