require 'rails_helper'
require_relative 'pages/login_page'
require_relative 'pages/admin_page'

describe 'admins' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:admin_page) { Features::Pages::AdminPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'only has 1 admin (current one)' do
    visit backend_admins_path
    expect(page).to have_current_path(backend_admins_path)
    expect(page).to have_content('Foo Bar')
    expect(page).to have_content('foo@bar.baz')
  end

  it 'show redirects to edit' do
    visit backend_admin_path(login_page.admin)
    expect(page).to have_current_path(edit_backend_admin_path(login_page.admin))
  end

  it 'create new admin' do
    admin_page.visit
    page.click_link 'Toevoegen'

    expect(page).to have_current_path(new_backend_admin_path)

    admin_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    expect(page).to have_current_path(backend_admins_path)
    expect(page).to have_content('Beheerder werd toegevoegd.')
    expect(page).to have_content('Erik Bauffman')
    expect(page).to have_content('erik@bauffman.be')
  end

  it 'login with new admin' do
    admin_page.visit
    page.click_link 'Toevoegen'
    admin_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    login_page.logout
    login_page.login('erik@bauffman.be', 'foo')
    expect(page).to have_current_path(backend_path)
  end

  it 'edit an admin' do
    admin_page.visit
    page.find('tbody td:last a:first').click
    admin_page.submit_with('Martha', 'Kauffman', 'martha@kauffman.com')

    expect(page).to have_current_path(backend_admins_path)
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

    expect(page).to have_current_path(backend_path)
  end

  it 'destroy created admin' do
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
