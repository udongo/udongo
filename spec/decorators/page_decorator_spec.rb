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

  describe '#path' do
    it 'route set' do
      page = create(:page, route: 'backend_path')
      expect(page.decorate.path).to eq '/backend'
    end

    describe 'route set' do
      before(:each) do
        @team = create(:page)
        @team.seo(:nl).slug = 'team'
        @team.seo(:nl).save

        @devs = create(:page, parent: @team)
        @devs.seo(:nl).slug = 'devs'
        @devs.seo(:nl).save

        @employee = create(:page, parent: @devs)
        @employee.seo(:nl).slug = 'employee'
        @employee.seo(:nl).save
      end

      it 'first level' do
        @page = create(:page)
        expect(@team.decorate.path(:nl)).to eq '/team'
      end

      it 'second level' do
        expect(@devs.decorate.path(:nl)).to eq '/team/devs'
      end

      it 'third level' do
        expect(@employee.decorate.path(:nl)).to eq '/team/devs/employee'
      end
    end
    it 'no route set' do
      page = create(:page)
      expect(page.decorate.path).to eq '/'
    end
  end

  it '#respond_to?' do
    expect(create(:page).decorate).to respond_to(:options_for_parents, :path)
  end
end
