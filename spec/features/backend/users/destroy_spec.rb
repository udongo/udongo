require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/user_page'

describe 'destroy users' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:user_page) { Features::Pages::UserPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'create user and destroy it' do
    user_page.visit
    page.click_link 'Toevoegen'

    user_page.submit_with('Martha', 'Kauffman', 'martha@kauffman.be', 'martha')

    page.find(:path, '//table/tbody/tr[1]/td[3]/a[2]').click

    expect(page).to have_current_path(backend_users_path)
    expect(page).to have_content('Gebruiker werd verwijderd.')
    expect(page).not_to have_content('Martha Kauffman')
    expect(page).not_to have_content('martha@kauffman.be')
  end
end
