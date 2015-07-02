require 'rails_helper'

describe PageDecorator do
  describe '#options_for_parents' do
    before(:each) do
      @a = create(:page)
      @b = create(:page, parent: @a)
      @c = create(:page, parent: @a)
    end

    it 'disabled' do
      expected = <<TEXT
<option value=\"#{@a.id}\">#{@a.description}</option>
<option disabled=\"disabled\" value=\"#{@b.id}\">- #{@b.description}</option>
<option value=\"#{@c.id}\">- #{@c.description}</option>
TEXT
      result = @a.decorate.options_for_parents(disabled: @b.id)
      expect(result).to eq expected.strip
    end

    it 'selected' do
      expected = <<TEXT
<option selected=\"selected\" value=\"#{@a.id}\">#{@a.description}</option>
<option value=\"#{@b.id}\">- #{@b.description}</option>
<option value=\"#{@c.id}\">- #{@c.description}</option>
TEXT
      result = @b.decorate.options_for_parents
      expect(result).to eq expected.strip
    end
  end

  it '#respond_to?' do
    expect(create(:page).decorate).to respond_to(:options_for_parents)
  end
end
