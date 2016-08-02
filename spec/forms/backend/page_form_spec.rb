require 'rails_helper'

describe Backend::PageForm do
  let(:klass) { described_class }
  let(:valid_params) do
    {
      description: 'bar'
    }
  end
  let(:instance) { klass.new(Page.new) }

  describe 'validations' do
    describe 'presence' do
      it :description do
        params = valid_params.merge(description: nil)
        expect(instance.save(params)).to eq false
      end
    end
  end

  describe '#save' do
    it 'create' do
      expect(instance.save(valid_params)).to eq true

      page = Page.first
      expect(page.description).to eq 'bar'
    end

    it 'update' do
      page = create(:page, valid_params)

      expect(klass.new(page).save(
        description: 'baz'
      )).to eq true

      page = Page.first
      expect(page.description).to eq 'baz'
    end
  end

  describe '#persisted?' do
    it :true do
      page = create(:page)
      expect(klass.new(page)).to be_persisted
    end

    it :false do
      expect(klass.new(Page.new)).not_to be_persisted
    end
  end

  it '#respond_to' do
    expect(klass.new(Page.new)).to respond_to(:save, :persisted?, :page)
  end
end
