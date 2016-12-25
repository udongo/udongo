require_relative 'page'

class Features::Pages::SnippetPage < Features::Pages::Page
  # def submit_with(first_name, last_name, email, password = nil)
  #   fill_in 'admin[first_name]', with: first_name, match: :first
  #   fill_in 'admin[last_name]', with: last_name, match: :first
  #   fill_in 'admin[email]', with: email, match: :first
  #
  #   if password
  #     fill_in 'admin[password]', with: password, match: :first
  #     fill_in 'admin[password_confirmation]', with: password, match: :first
  #   end
  #
  #   submit
  # end
  #
  # def submit
  #   click_button 'Opslaan'
  # end

  def visit
    super '/backend/snippets'
  end
end
