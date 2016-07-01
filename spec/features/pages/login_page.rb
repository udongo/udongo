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
    fill_in 'session[email]', with: email
    fill_in 'session[password]', with: password
    click_button 'Inloggen'
  end

  def logout
    click_link('Uitloggen')
  end

  def visit
    super '/backend/sessions/new'
  end
end
