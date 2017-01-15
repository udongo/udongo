require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/admin_page'

describe 'create admins' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:admin_page) { Features::Pages::AdminPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'create new admin without success' do
    admin_page.visit
    admin_page.click_add
    admin_page.submit_with(nil, nil, 'erik@bauffman.be', 'foo')

    expect(page).to have_current_path('/backend/admins')
    expect(page).to have_content('Er trad een fout op.')
  end

  it 'create new admin successfully' do
    admin_page.visit
    admin_page.click_add
    admin_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    expect(page).to have_current_path('/backend/admins')
    expect(page).to have_content('Beheerder werd toegevoegd.')
    expect(page).to have_content('Erik Bauffman')
    expect(page).to have_content('erik@bauffman.be')
  end

  it 'login with new admin' do
    admin_page.visit
    admin_page.click_add
    admin_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    login_page.logout
    login_page.login('erik@bauffman.be', 'foo')
    expect(page).to have_current_path('/backend')
  end
end
