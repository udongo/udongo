require_relative 'page'

class Features::Pages::LoginPage < Features::Pages::Page
  def initialize
    db_setup
  end

  def db_setup
    FactoryGirl.create(
      :admin,
      first_name: 'Foo',
      last_name: 'Bar',
      email: 'foo@bar.baz',
      password: 'sekret',
      password_confirmation: 'sekret'
    )
  end

  def login(email = 'foo@bar.baz', password = 'sekret')
    page.fill_in 'session[email]', with: email, match: :first
    page.fill_in 'session[password]', with: password, match: :first
    page.click_button 'Inloggen', match: :first
  end

  def logout
    page.click_link('Uitloggen')
  end

  def visit
    super '/backend/sessions/new'
  end
end
