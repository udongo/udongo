require 'rails_helper'

describe CollectionHelper do
  I18n.with_locale(:nl) do
    describe '#options_for_collection' do
      it 'default' do
        expect(options_for_collection(:name, [])).to eq []
      end

      it 'values' do
        expect(options_for_collection(:form_field_type, %w(string))).to eq [%w(Tekstregel string)]
      end
    end
  end
end
