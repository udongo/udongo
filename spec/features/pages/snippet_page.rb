require_relative 'page'

class Features::Pages::SnippetPage < Features::Pages::Page

  def fill_in_general(identifier, description)
    fill_in 'Interne naam', with: identifier
    fill_in 'Beschrijving', with: description
  end

  def fill_in_translation(title, content)
    fill_in 'Titel', with: title
    fill_in 'Inhoud', with: content
  end

  def click_edit
    find('tbody td:last a:first').click
  end

  def submit
    click_button 'Opslaan'
  end

  def visit
    super '/backend/snippets'
  end
end
