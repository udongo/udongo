require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/admin_page'

describe 'destroy admins' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:admin_page) { Features::Pages::AdminPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'create admin and destroy it' do
    admin_page.visit
    page.click_link 'Toevoegen'

    admin_page.submit_with('Martha', 'Kauffman', 'martha@kauffman.be', 'martha')

    page.find(:path, '//table/tbody/tr[2]/td[3]/a[2]').click

    expect(page).to have_current_path(backend_admins_path)
    expect(page).to have_content('Beheerder werd verwijderd.')
    expect(page).not_to have_content('Martha Kauffman')
    expect(page).not_to have_content('martha@kauffman.be')
  end
end
