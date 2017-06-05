require 'rails_helper'

describe LinkHelper do
  include IconHelper

  before(:each) do
    I18n.locale = :nl
    @admin = create(:admin, id: 37)
  end

  describe '#link_to_show' do
    it 'object param' do
      expected = '<a title="Bekijk" href="/backend/admins/37"><i class="fa fa-search"></i></a>'
      expect(link_to_show([:backend, @admin])).to eq expected
    end

    it 'string param' do
      expected = '<a title="Bekijk" href="/backend/admins/37"><i class="fa fa-search"></i></a>'
      expect(link_to_show(backend_admin_path(@admin))).to eq expected
    end
  end

  describe '#link_to_edit_with_label' do
    it '[:backend, page]' do
      page = create(:page, id: 37)
      page.translation(:nl).title = 'Foo'
      page.save!

      expected = '<a title="Bewerk" href="/backend/pages/37/edit">Foo</a>'
      expect(link_to_edit_with_label([:backend, page], :nl)).to eq expected
    end

    it '[:backend, admin]' do
      admin = create(:admin, id: 101)

      expected = '<a title="Bewerk" href="/backend/admins/101/edit">Beheerder: 101</a>'
      expect(link_to_edit_with_label([:backend, admin], :nl)).to eq expected
    end
  end

  describe '#link_to_edit' do
    it 'object param' do
      expected = '<a title="Bewerk" href="/backend/admins/37/edit"><i class="fa fa-pencil-square-o"></i></a>'
      expect(link_to_edit([:backend, @admin])).to eq expected
    end

    it 'string param' do
      expected = '<a title="Bewerk" href="/backend/admins/37/edit"><i class="fa fa-pencil-square-o"></i></a>'
      expect(link_to_edit(edit_backend_admin_path(@admin))).to eq expected
    end
  end

  it '#link_to_edit_translation' do
    page = create(:page, id: 37)
    expected = '<a title="Bewerk" href="/backend/pages/37/edit/nl"><i class="fa fa-pencil-square-o"></i></a>'
    expect(link_to_edit_translation([:backend, page])).to eq expected
  end

  describe '#link_to_delete' do
    it 'object param' do
      expected = '<a data-confirm="Ben je zeker?" title="Verwijder" rel="nofollow" data-method="delete" href="/backend/admins/37"><i class="fa fa-trash"></i></a>'
      expect(link_to_delete([:backend, @admin])).to eq expected
    end

    it 'string param' do
      expected = '<a data-confirm="Ben je zeker?" title="Verwijder" rel="nofollow" data-method="delete" href="/backend/admins/37"><i class="fa fa-trash"></i></a>'
      expect(link_to_delete(backend_admin_path(@admin))).to eq expected
    end
  end

  describe '#object_label' do
    it 'page > title' do
      obj = create(:page)
      obj.translation(:nl).title = 'Foo title'
      obj.save!

      expect(object_label(obj, :nl)).to eq 'Foo title'
    end

    it 'search_module > name' do
      obj = create(:search_module, name: 'Foo name')
      expect(object_label(obj, :nl)).to eq 'Foo name'
    end

    it 'asset > description' do
      obj = create(:asset, description: 'Foo description')
      expect(object_label(obj, :nl)).to eq 'Foo description'
    end

    it 'admin > undefined' do
      obj = create(:admin, first_name: 'Foo', last_name: 'Bar')
      expect(object_label(obj, :nl)).to eq "Beheerder: #{obj.id}"
    end

    describe 'use the right locale' do
      it 'locale: nl' do
        obj = create(:page)
        obj.translation(:nl).title = 'NL foo'
        obj.translation(:en).title = 'EN foo'
        obj.save!

        expect(object_label(obj, :nl)).to eq 'NL foo'
      end

      it 'locale: en' do
        obj = create(:page)
        obj.translation(:nl).title = 'NL foo'
        obj.translation(:en).title = 'EN foo'
        obj.save!

        expect(object_label(obj, :en)).to eq 'EN foo'
      end
    end

    describe 'value as an array' do
      it '[:backend, page]' do
        obj = create(:page)
        obj.translation(:nl).title = 'Foo title'
        obj.save!

        expect(object_label([:backend, obj], :nl)).to eq 'Foo title'
      end

      it '[:backend, navigation, navigation_item]' do
        nav = create(:navigation)
        nav_item = create(:navigation_item, navigation: nav)

        expect(object_label([:backend, nav, nav_item], :nl)).to eq "Navigatie-item: #{nav_item.id}"
      end
    end
  end

  it '#respond_to?' do
    expect(self).to respond_to(
      :link_to_show, :link_to_edit, :link_to_delete, :link_to_edit_with_label
    )
  end
end
