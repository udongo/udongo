require 'rails_helper'

describe 'authentication' do
  describe 'redirects when not logged in' do
    it '/backend redirecs to /backend/sessions/new' do
      visit '/backend'
      expect(page).to have_current_path('/backend/sessions/new')
    end

    it 'redirects to login if not logged in' do
      visit '/backend/admins'
      expect(page).to have_current_path('/backend/sessions/new')
    end
  end

  describe 'login' do
    before(:each) do
      create(:admin, first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.baz', password: 'sekret', password_confirmation: 'sekret')
    end

    it 'valid login credentials' do
      visit '/backend/sessions/new'
      page.fill_in 'session[email]', with: 'foo@bar.baz', match: :first
      page.fill_in 'session[password]', with: 'sekret', match: :first
      page.click_button 'Inloggen', match: :first

      expect(page).to have_current_path('/backend')
      expect(page).to have_content('Foo Bar')
    end

    it 'inavlid login credentials' do
      visit '/backend/sessions/new'
      page.fill_in 'session[email]', with: 'bla', match: :first
      page.fill_in 'session[password]', with: 'bla', match: :first
      page.click_button 'Inloggen', match: :first

      expect(page).to have_current_path('/backend/sessions')
      expect(page).to have_content('Ongeldige login gegevens.')
    end
  end

  it 'logout' do
    create(:admin, first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.baz', password: 'sekret', password_confirmation: 'sekret')

    visit '/backend/sessions/new'
    page.fill_in 'session[email]', with: 'foo@bar.baz', match: :first
    page.fill_in 'session[password]', with: 'sekret', match: :first
    page.click_button 'Inloggen', match: :first

    expect(page).to have_current_path('/backend')
    expect(page).to have_content('Foo Bar')

    page.click_link('Uitloggen')
    expect(page).to have_current_path('/backend/sessions/new')
  end
end
