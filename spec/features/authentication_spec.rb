require 'rails_helper'
require_relative 'pages/login_page'

describe 'authentication' do
  let(:login_page) { Features::Pages::LoginPage.new }

  describe 'redirects when not logged in' do
    it 'dashboard redirecs to login page' do
      visit backend_path
      expect(page).to have_current_path(new_backend_session_path)
    end

    it 'redirects to login page if not logged in' do
      visit backend_admins_path
      expect(page).to have_current_path(new_backend_session_path)
    end
  end

  describe 'login' do
    it 'valid login credentials' do
      login_page.visit
      login_page.login('foo@bar.baz', 'sekret')

      expect(page).to have_current_path(backend_path)
      expect(page).to have_content('Foo Bar')
    end

    it 'via admins' do
      visit backend_admins_path
      login_page.login

      expect(page).to have_current_path(backend_admins_path)
      expect(page).to have_content('Foo Bar')
    end

    it 'invalid login credentials' do
      login_page.visit
      login_page.login('foo', 'bar')

      expect(page).to have_current_path('/backend/sessions')
      expect(page).to have_content('Ongeldige login gegevens.')
    end
  end

  it 'logout' do
    login_page.visit
    login_page.login('foo@bar.baz', 'sekret')

    expect(page).to have_current_path(backend_path)
    expect(page).to have_content('Foo Bar')

    login_page.logout
    expect(page).to have_current_path(new_backend_session_path)
  end
end
