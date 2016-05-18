require 'rails_helper'

describe Udongo::ObjectPath do
  let(:klass) { described_class }

  describe '.find' do
    it '[:backend]' do
      expect(klass.find([:backend])).to eq 'backend_path'
    end

    it '[admin]' do
      admin = create(:admin)
      expect(klass.find(admin)).to eq 'admin_path'
    end

    it 'page decorated' do
      page = create(:page).decorate
      expect(klass.find(page)).to eq 'page_path'
    end

    it '[:backend, @admin]' do
      admin = create(:admin)
      expect(klass.find([:backend, admin])).to eq 'backend_admin_path'
    end

    it '[:backend, @admin, :foo]' do
      admin = create(:admin)
      expect(klass.find([:backend, admin, :foo])).to eq 'backend_admin_foo_path'
    end

    it '[:backend, @page] decorated' do
      page = create(:page).decorate
      expect(klass.find([:backend, page])).to eq 'backend_page_path'
    end
  end

  describe '.remove_symbols' do
    it 'no symbols' do
      admin = create(:admin)
      expect(klass.remove_symbols([admin])).to eq [admin]
    end

    it 'only symbols' do
      expect(klass.remove_symbols([:foo, :bar, :baz])).to eq []
    end

    it 'mix of symbols and models' do
      admin = create(:admin)
      expect(klass.remove_symbols([:foo, admin, :bar, admin, :baz, admin])).to eq [admin, admin, admin]
    end
  end

  it '.respond_to?' do
    expect(klass).to respond_to(:find, :remove_symbols)
  end
end
