require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/admin_page'

describe 'admins' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:admin_page) { Features::Pages::AdminPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'edit an admin without success' do
    admin_page.visit
    page.find('tbody td:last a:first').click
    admin_page.submit_with(nil, nil, 'martha@kauffman.com')

    expect(page).to have_current_path("/backend/admins/#{Admin.first.id}")
    expect(page).to have_content('Er trad een fout op.')
  end

  it 'edit an admin successfully' do
    admin_page.visit
    page.find('tbody td:last a:first').click
    admin_page.submit_with('Martha', 'Kauffman', 'martha@kauffman.com')

    expect(page).to have_current_path('/backend/admins')
    expect(page).to have_content('De wijzigingen werden opgeslagen.')
    expect(page).to have_content('Martha Kauffman')
    expect(page).to have_content('martha@kauffman.com')
  end

  it 'edit admin password and login with new password' do
    admin_page.visit
    page.find('tbody td:last a:first').click
    admin_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'new-pw')
    login_page.logout
    login_page.login('erik@bauffman.be', 'new-pw')

    expect(page).to have_current_path('/backend')
  end
end
