require_relative 'page'

class Features::Pages::EmailTemplatePage < Features::Pages::Page

  def fill_in_general(identifier, description)
    fill_in 'Interne naam', with: identifier
    fill_in 'Beschrijving', with: description
  end

  def fill_in_settings(sender_name, sender_email, cc, bcc)
    fill_in 'Naam afzender', with: sender_name
    fill_in 'E-mail adres afzender', with: sender_email
    fill_in 'CC', with: cc
    fill_in 'BCC', with: bcc
  end

  def fill_in_translation(subject, plain_content, html_content)
    fill_in 'Onderwerp', with: subject
    fill_in 'Tekstuele inhoud', with: plain_content
    fill_in 'HTML inhoud', with: html_content
  end

  def click_edit
    find('tbody td:last a:first').click
  end

  def submit
    click_button 'Opslaan'
  end

  def visit
    super '/backend/email_templates'
  end
end
