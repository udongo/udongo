require 'rails_helper'

describe IconHelper do
  describe '#icon' do
    it 'name as symbol' do
      output = icon(:foo)
      expect(output).to eq '<i class="fa fa-foo"></i>'
      expect(output).to be_a(ActiveSupport::SafeBuffer)
    end

    it 'name as string' do
      output = icon('foo')
      expect(output).to eq '<i class="fa fa-foo"></i>'
      expect(output).to be_a(ActiveSupport::SafeBuffer)
    end

    it 'name with underscores' do
      output = icon(:foo_bar_baz)
      expect(output).to eq '<i class="fa fa-foo-bar-baz"></i>'
      expect(output).to be_a(ActiveSupport::SafeBuffer)
    end

    it 'with a label' do
      output = icon(:foo, 'Bar')
      expect(output).to eq '<i class="fa fa-foo"></i>&nbsp;Bar'
      expect(output).to be_a(ActiveSupport::SafeBuffer)
    end
  end
end
