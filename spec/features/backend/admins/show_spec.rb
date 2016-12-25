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

  it 'show redirects to edit' do
    visit "/backend/admins/#{login_page.admin.id}"
    expect(page).to have_current_path("/backend/admins/#{login_page.admin.id}/edit")
  end
end

