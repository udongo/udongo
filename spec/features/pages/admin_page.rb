require_relative 'page'

class Features::Pages::AdminPage < Features::Pages::Page
  def submit_with(first_name, last_name, email, password = nil)
    select 'nl', from: 'Taal'
    fill_in 'Voornaam', with: first_name
    fill_in 'Achternaam', with: last_name
    fill_in 'E-mail', with: email

    if password
      fill_in 'Wachtwoord', with: password, match: :first
      fill_in 'Wachtwoord bevestiging', with: password
    end

    submit
  end

  def click_add
    click_link 'Toevoegen'
  end

  def submit
    click_button 'Opslaan'
  end

  def visit
    super '/backend/admins'
  end
end
