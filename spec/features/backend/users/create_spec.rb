require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/user_page'

describe 'create users' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:user_page) { Features::Pages::UserPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'create new user without success' do
    user_page.visit
    user_page.click_add
    user_page.submit_with(nil, nil, 'erik@bauffman.be', 'foo')

    expect(page).to have_current_path('/backend/users')
    expect(page).to have_content('Er trad een fout op.')
  end

  it 'create new user successfully' do
    user_page.visit
    user_page.click_add
    user_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    expect(page).to have_current_path('/backend/users')
    expect(page).to have_content('Gebruiker werd toegevoegd.')
    expect(page).to have_content('Erik Bauffman')
    expect(page).to have_content('erik@bauffman.be')
  end
end
