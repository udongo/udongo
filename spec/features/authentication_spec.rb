require 'rails_helper'

describe 'authentication' do
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
    before(:each) do
      create(:admin, first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.baz', password: 'sekret', password_confirmation: 'sekret')
    end

    it 'valid login credentials' do
      visit new_backend_session_path
      page.fill_in 'session[email]', with: 'foo@bar.baz', match: :first
      page.fill_in 'session[password]', with: 'sekret', match: :first
      page.click_button 'Inloggen', match: :first

      expect(page).to have_current_path(backend_path)
      expect(page).to have_content('Foo Bar')
    end

    it 'inavlid login credentials' do
      visit new_backend_session_path
      page.fill_in 'session[email]', with: 'bla', match: :first
      page.fill_in 'session[password]', with: 'bla', match: :first
      page.click_button 'Inloggen', match: :first

      expect(page).to have_current_path('/backend/sessions')
      expect(page).to have_content('Ongeldige login gegevens.')
    end
  end

  it 'logout' do
    create(:admin, first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.baz', password: 'sekret', password_confirmation: 'sekret')

    visit new_backend_session_path
    page.fill_in 'session[email]', with: 'foo@bar.baz', match: :first
    page.fill_in 'session[password]', with: 'sekret', match: :first
    page.click_button 'Inloggen', match: :first

    expect(page).to have_current_path(backend_path)
    expect(page).to have_content('Foo Bar')

    page.click_link('Uitloggen')
    expect(page).to have_current_path(new_backend_session_path)
  end
end
