require 'rails_helper'
require_relative '../../pages/login_page'
require_relative '../../pages/snippet_page'

describe 'edit snippets' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:snippet_page) { Features::Pages::SnippetPage.new }

  before(:each) do
    login_page.visit
    login_page.login

    @snippet = create(:snippet, identifier: 'foo', description: 'bar')
    @snippet.translation(:nl).title = 'Snippet title'
    @snippet.translation(:nl).content = 'Snippet content'
    @snippet.save
  end

  describe 'general' do
    it 'fields are prefilled' do
      snippet_page.visit
      snippet_page.click_edit

      expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit")
      expect(find_field('Interne naam').value).to eq 'foo'
      expect(find_field('Beschrijving').value).to eq 'bar'
    end

    it 'with success' do
      snippet_page.visit
      snippet_page.click_edit
      snippet_page.fill_in_general('foo 2', 'bar 2')
      snippet_page.submit

      snippet = Snippet.first
      expect(snippet.identifier).to eq 'foo 2'
      expect(snippet.description).to eq 'bar 2'

      expect(page).to have_current_path("/backend/snippets/#{snippet.id}/edit")
      expect(page).to have_content('Snippet werd gewijzigd.')
    end

    it 'without success' do
      snippet_page.visit
      snippet_page.click_edit
      snippet_page.fill_in_general('', '')
      snippet_page.submit

      snippet = Snippet.first
      expect(snippet.identifier).to eq 'foo'
      expect(snippet.description).to eq 'bar'

      expect(page).to have_current_path("/backend/snippets/#{snippet.id}")
      expect(page).to have_content('Er trad een fout op.')
    end
  end

  describe 'translation' do
    it 'fields are prefilled' do
      snippet_page.visit
      snippet_page.click_edit
      page.click_link 'NL'

      expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit/nl")
      expect(find_field('Titel').value).to eq 'Snippet title'
      expect(find_field('Inhoud').value).to eq 'Snippet content'
    end

    it 'with success' do
      snippet_page.visit
      snippet_page.click_edit
      page.click_link 'NL'
      snippet_page.fill_in_translation('Snippet title 2', 'Snippet content 2')
      snippet_page.submit

      snippet = Snippet.first
      expect(snippet.translation(:nl).title).to eq 'Snippet title 2'
      expect(snippet.translation(:nl).content).to eq 'Snippet content 2'

      expect(page).to have_current_path("/backend/snippets/#{snippet.id}/edit/nl")
    end
  end
end
