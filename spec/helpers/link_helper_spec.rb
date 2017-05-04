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

  it '#respond_to?' do
    expect(self).to respond_to(:link_to_show, :link_to_edit, :link_to_delete)
  end
end
