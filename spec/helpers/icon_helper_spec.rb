require 'rails_helper'

describe IconHelper do
  describe '#icon' do
    it 'name as symbol' do
      output = icon(:foo)
      expect(output).to eq '<i class="fa fa-foo"></i>'
    end

    it 'name as string' do
      output = icon('foo')
      expect(output).to eq '<i class="fa fa-foo"></i>'
    end

    it 'name with underscores' do
      output = icon(:foo_bar_baz)
      expect(output).to eq '<i class="fa fa-foo-bar-baz"></i>'
    end

    context 'when passing a label' do
      it 'it returns the icon HTML with a label' do
        output = icon(:foo, 'Bar')
        expect(output).to eq '<i class="fa fa-foo"></i>&nbsp;Bar'
      end

      it 'returns an instance of ActiveSupport::SafeBuffer' do
        output = icon(:foo, 'Bar')
        expect(output).to be_a(ActiveSupport::SafeBuffer)
      end
    end

    context 'when not passing a label' do
      it 'returns an instance of ActiveSupport::SafeBuffer' do
        output = icon(:foo, 'Bar')
        expect(output).to be_a(ActiveSupport::SafeBuffer)
      end
    end
  end
end
