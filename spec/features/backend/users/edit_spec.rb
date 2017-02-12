require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/user_page'

describe 'users' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:user_page) { Features::Pages::UserPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'edit a user without success' do
    user_page.visit
    user_page.click_add
    user_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')
    page.find('tbody td:last a:first').click
    user_page.submit_with(nil, nil, 'martha@kauffman.com')

    expect(page).to have_current_path("/backend/users/#{User.first.id}")
    expect(page).to have_content('Er trad een fout op.')
  end

  it 'edit a user successfully' do
    user_page.visit
    user_page.click_add
    user_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')
    page.find('tbody td:last a:first').click
    user_page.submit_with('Martha', 'Kauffman', 'martha@kauffman.com')

    expect(page).to have_current_path('/backend/users')
    expect(page).to have_content('De wijzigingen werden opgeslagen.')
    expect(page).to have_content('Martha Kauffman')
    expect(page).to have_content('martha@kauffman.com')
  end
end
