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

  it 'show redirects to edit' do
    user_page.visit
    user_page.click_add
    user_page.submit_with('Erik', 'Bauffman', 'erik@bauffman.be', 'foo')

    visit "/backend/users/#{User.first.id}"
    expect(page).to have_current_path("/backend/users/#{User.first.id}/edit")
  end
end

